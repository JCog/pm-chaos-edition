#include "chaos.h"
#include "common.h"
#include "game_modes.h"
#include "dx/debug_menu.h"
#include "world/actions.h"

#define CHAOS_DEBUG 1

#define MAX_EFFECT_INTERVAL 15
#define MAX_EFFECT_COUNT 10
#define MIN_EFFECT_LENGTH 10
#define MAX_SECONDS_DEFAULT 45

#define MAX_EFFECT_INTERVAL_FRAMES (MAX_EFFECT_INTERVAL * 30)
#define MIN_EFFECT_LENGTH_FRAMES (MIN_EFFECT_LENGTH * 30)

enum ChaosEffect {
    CHAOS_PERIL,
    CHAOS_POS,
    CHAOS_LEVITATE,
    CHAOS_ACTOR_MAGNET,
    CHAOS_KNOCKBACK,
    CHAOS_LAVA,
    CHAOS_WIDE,
    CHAOS_SLOWGO,
    CHAOS_TOP_DOWN_CAM,
    CHAOS_MAX,
};

enum EffectType {
    CHAOS_INSTANT,
    CHAOS_CONTINUOUS,
    CHAOS_ON_OFF,
};

struct EffectData {
    const char *name;
    enum EffectType type;
    s16 timer;
    s8 maxSeconds;
    void (*func)();
    void (*off)();
};

struct NpcScaleData {
    s8 id;
    Vec3f scale;
};

u32 frameCount = 0;
const enum GameMode badModes[] = {
    GAME_MODE_STARTUP, GAME_MODE_LOGOS, GAME_MODE_TITLE_SCREEN, GAME_MODE_ENTER_DEMO_WORLD, GAME_MODE_ENTER_WORLD,
    GAME_MODE_GAME_OVER, GAME_MODE_FILE_SELECT, GAME_MODE_END_FILE_SELECT, GAME_MODE_INTRO, GAME_MODE_DEMO
};

#if CHAOS_DEBUG
static enum ChaosEffect selectedEffect = 0;
static s16 selectedTimer = 10;
#endif
b8 chaosSlowGo = FALSE;
b8 chaosTopDownCam = FALSE;
static u8 activeEffects = 0;
static u32 effectCountdown = 1;
static struct NpcScaleData npcScaleBuffer[MAX_NPCS] = {-1, {0, 0, 0}};

static void peril_sound() {
    if (frameCount % 25 == 0) {
        sfx_play_sound(SOUND_PERIL);
    }
}

static void pos_load() {
    static Vec3f saved_pos;
    if (frameCount % 30 == 20) {
        saved_pos = gPlayerStatus.pos;
    } else if (frameCount % 30 == 0) {
        gPlayerStatus.pos = saved_pos;
    }
}

static void levitate() {
    if (gPlayerStatus.timeInAir == 0) {
        gPlayerStatus.pos.y += 5;
    }
    gPlayerStatus.flags |= 1 << 1;
    gPlayerStatus.flags &= ~(1 << 2);
    gPlayerStatus.timeInAir = 1;
    gPlayerStatus.gravityIntegrator[0] = 2;
    gPlayerStatus.gravityIntegrator[1] = 0;
    gPlayerStatus.gravityIntegrator[2] = 0;
    gPlayerStatus.gravityIntegrator[3] = -0.0115200001746f;

    if (gGameStatus.peachFlags & (1 << 0)) {
        PlayerActionsTable[5].flag = TRUE;
    }
}

static void magnet_pos_step(Vec3f *pos, f32 speed) {
    if (gPlayerStatus.pos.x - pos->x > speed) {
        pos->x += speed;
    } else if (gPlayerStatus.pos.x - pos->x < speed) {
        pos->x -= speed;
    }
    if (gPlayerStatus.pos.y - pos->y > speed) {
        pos->y += speed;
    } else if (gPlayerStatus.pos.y - pos->y < speed) {
        pos->y -= speed;
    }
    if (gPlayerStatus.pos.z - pos->z > speed) {
        pos->z += speed;
    } else if (gPlayerStatus.pos.z - pos->z < speed) {
        pos->z -= speed;
    }
}

static void actor_magnet() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc != NULL) {
            magnet_pos_step(&npc->pos, 2);
        }
    }
    for (u32 i = 0; i < MAX_ENTITIES; i++) {
        Entity *entity = (*gCurrentEntityListPtr)[i];
        if (entity != NULL) {
            magnet_pos_step(&entity->pos, 2);
        }
    }
    for (u32 i = 0; i < MAX_ITEM_ENTITIES; i++) {
        ItemEntity *entity = (gCurrentItemEntities)[i];
        if (entity != NULL) {
            magnet_pos_step(&entity->pos, 2);
        }
    }
}

static void knockback() {
    if (frameCount % 60 == 0) {
        set_action_state(ACTION_STATE_KNOCKBACK);
    }
}

static void lava() {
    set_action_state(ACTION_STATE_HIT_LAVA);
}

static void wide() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        npcScaleBuffer[i].id = -1;
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc != NULL) {
            npcScaleBuffer[i].id = npc->npcID;
            npcScaleBuffer[i].scale.x = npc->scale.x;
            npcScaleBuffer[i].scale.z = npc->scale.z;
            npcScaleBuffer[i].scale.y = npc->scale.y;
            npc->scale.x *= 4;
            npc->scale.z *= 4;
            npc->scale.y *= 0.5;
        }
    }
}

static void wide_off() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        if (npcScaleBuffer[i].id == -1) {
            continue;
        }
        Npc *npc = get_npc_safe(npcScaleBuffer[i].id);
        if (npc != NULL) {
            npc->scale.x = npcScaleBuffer[i].scale.x;
            npc->scale.z = npcScaleBuffer[i].scale.z;
            npc->scale.y = npcScaleBuffer[i].scale.y;
        }
        npcScaleBuffer[i].id = -1;
    }
}

static void slowGo() {
    chaosSlowGo = !chaosSlowGo;
}

static void topDownCam() {
    chaosTopDownCam = !chaosTopDownCam;
}

struct EffectData effectData[CHAOS_MAX] = {
    {"Peril Sound",     CHAOS_CONTINUOUS,   0,  MAX_SECONDS_DEFAULT,    peril_sound,    NULL},
    {"Rewind",          CHAOS_CONTINUOUS,   0,  MAX_SECONDS_DEFAULT,    pos_load,       NULL},
    {"Levitate",        CHAOS_CONTINUOUS,   0,  10,                     levitate,       NULL},
    {"Actor Magnet",    CHAOS_CONTINUOUS,   0,  MAX_SECONDS_DEFAULT,    actor_magnet,   NULL},
    {"Knockback",       CHAOS_CONTINUOUS,   0,  MAX_SECONDS_DEFAULT,    knockback,      NULL},
    {"Lava",            CHAOS_INSTANT,      0,  2,                      lava,           NULL},
    {"Wide",            CHAOS_ON_OFF,       0,  MAX_SECONDS_DEFAULT,    wide,           wide_off},
    {"Slow Go",         CHAOS_ON_OFF,       0,  MAX_SECONDS_DEFAULT,    slowGo,         slowGo},
    {"Top-Down Cam",    CHAOS_ON_OFF,       0,  MAX_SECONDS_DEFAULT,    topDownCam,     topDownCam},
};

static void draw_effect_list() {
    char fmtBuf[128];
    u8 index = 0;
    #if CHAOS_DEBUG
    sprintf(fmtBuf, "Selected: %ds - %d %s", selectedTimer, selectedEffect, effectData[selectedEffect].name);
    #else
    sprintf(fmtBuf, "Effect Countdown: %lu", effectCountdown / 30);
    #endif
    dx_debug_draw_ascii(fmtBuf, 0, 15, 55);
    for (u32 i = 0; i < CHAOS_MAX; i++) {
        if (effectData[i].timer > 0) {
            sprintf(fmtBuf, "%s: %d", effectData[i].name, effectData[i].timer / 30);
            dx_debug_draw_ascii(fmtBuf, 0, 15, 65 + index * 10);
            index++;
        }
    }
}

void update_chaos() {
    gPlayerData.coins = get_game_mode();
    for (u32 i = 0; i < 10; i++) {
        if (get_game_mode() == badModes[i]) {
            return;
        }
    }
    frameCount = gPlayerData.frameCounter / 2;
    effectCountdown--;

    // select a new effect
    #if CHAOS_DEBUG
    s32 buttons = gPlayerStatus.pressedButtons;
    if (buttons & BUTTON_D_LEFT) {
        selectedEffect += CHAOS_MAX - 1;
        selectedEffect %= CHAOS_MAX;
    } else if (buttons & BUTTON_D_RIGHT) {
        selectedEffect++;
        selectedEffect %= CHAOS_MAX;
    } else if (buttons & BUTTON_D_UP) {
        selectedTimer += 5;
    } else if (buttons & BUTTON_D_DOWN) {
        selectedTimer -= 5;
        if (selectedTimer < 0) {
            selectedTimer = 0;
        }
    } else if (buttons & BUTTON_R) {
        if (effectData[selectedEffect].type == CHAOS_INSTANT || effectData[selectedEffect].type == CHAOS_ON_OFF) {
            effectData[selectedEffect].func();
        }
        if (effectData[selectedEffect].type == CHAOS_ON_OFF || effectData[selectedEffect].type == CHAOS_CONTINUOUS) {
            effectData[selectedEffect].timer = selectedTimer * 30;
        }
    }
    #else
    if (effectCountdown == 0 && activeEffects < MAX_EFFECT_COUNT) {
        while (TRUE) {
            s32 id = rand_int(CHAOS_MAX - 1);
            if (effectData[id].timer > 0) {
                continue;
            }

            if (effectData[id].type == CHAOS_INSTANT || effectData[id].type == CHAOS_ON_OFF) {
                effectData[id].func();
            }
            if (effectData[id].type == CHAOS_ON_OFF || effectData[id].type == CHAOS_CONTINUOUS) {
                effectData[id].timer =
                    rand_int((effectData[id].maxSeconds - MIN_EFFECT_LENGTH) * 30) + MIN_EFFECT_LENGTH_FRAMES;
            }
            effectCountdown = rand_int(MAX_EFFECT_INTERVAL_FRAMES);
            break;
        }
    }
    #endif

    // update active effects
    draw_effect_list();
    activeEffects = 0;
    for (u32 i = 0; i < CHAOS_MAX; i++) {
        if (effectData[i].timer > 0) {
            activeEffects++;
            if (effectData[i].timer == 1 && effectData[i].off != NULL) {
                effectData[i].off();
            } else if (effectData[i].type == CHAOS_CONTINUOUS){
                effectData[i].func();
            }
            effectData[i].timer--;
        }
    }
}