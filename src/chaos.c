#include "chaos.h"
#include "common.h"
#include "game_modes.h"
#include "dx/debug_menu.h"
#include "world/actions.h"

enum ChaosEffect {
    CHAOS_PERIL,
    CHAOS_POS,
    CHAOS_LEVITATE,
    CHAOS_ACTOR_MAGNET,
    CHAOS_KNOCKBACK,
    CHAOS_LAVA,
    CHAOS_WIDE,
    CHAOS_END,
};

enum EffectType {
    CHAOS_INSTANT,
    CHAOS_CONTINUOUS,
    CHAOS_ON_OFF,
};

struct EffectData {
    const char *name;
    enum EffectType type;
    void (*func)();
};

u32 frameCount = 0;
s16 effectTimers[CHAOS_END];
const enum GameMode badModes[] = {
    GAME_MODE_STARTUP, GAME_MODE_LOGOS, GAME_MODE_TITLE_SCREEN, GAME_MODE_ENTER_DEMO_WORLD, GAME_MODE_ENTER_WORLD,
    GAME_MODE_GAME_OVER, GAME_MODE_FILE_SELECT, GAME_MODE_END_FILE_SELECT, GAME_MODE_INTRO, GAME_MODE_DEMO
};

#define MAX_EFFECT_INTERVAL 15
#define MAX_EFFECT_COUNT 10
#define MIN_EFFECT_LENGTH 10
#define MAX_EFFECT_LENGTH 45

#define MAX_EFFECT_INTERVAL_FRAMES (MAX_EFFECT_INTERVAL * 30)
#define MIN_EFFECT_LENGTH_FRAMES (MIN_EFFECT_LENGTH * 30)
#define MAX_MIN_EFFECT_LENGTH_FRAMES_DIFF ((MAX_EFFECT_LENGTH - MIN_EFFECT_LENGTH) * 30)

static u8 activeEffects = 0;
static u32 effectCountdown = 1;

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
    NpcList *npcList = gCurrentNpcListPtr;
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*npcList)[i];
        if (npc != NULL) {
            npc->scale.x *= 4;
            npc->scale.z *= 4;
            npc->scale.y *= 0.5;
        }
    }
}

struct EffectData effectData[CHAOS_END] = {
    {"Peril Sound",     CHAOS_CONTINUOUS,   peril_sound},
    {"Rewind",          CHAOS_CONTINUOUS,   pos_load},
    {"Levitate",        CHAOS_CONTINUOUS,   levitate},
    {"Actor Magnet",    CHAOS_CONTINUOUS,   actor_magnet},
    {"Knockback",       CHAOS_CONTINUOUS,   knockback},
    {"Lava",            CHAOS_INSTANT,      lava},
    {"Wide",            CHAOS_INSTANT,      wide},
};

static void draw_effect_list() {
    char fmtBuf[128];
    u8 index = 0;
    sprintf(fmtBuf, "Effect Countdown: %d", effectCountdown / 30);
    dx_debug_draw_ascii(fmtBuf, 0, 15, 55);
    for (u32 i = 0; i < CHAOS_END; i++) {
        if (effectTimers[i] > 0) {
            sprintf(fmtBuf, "%s: %d", effectData[i].name, effectTimers[i] / 30);
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
    if (effectCountdown == 0 && activeEffects < MAX_EFFECT_COUNT) {
        s32 newEffect = rand_int(CHAOS_END - 1);
        if (effectData[newEffect].type == CHAOS_INSTANT) {
            effectData[newEffect].func();
        } else if (effectTimers[newEffect] == 0) {
            effectTimers[newEffect] = rand_int(MAX_MIN_EFFECT_LENGTH_FRAMES_DIFF) + MIN_EFFECT_LENGTH_FRAMES;
        }
        effectCountdown = rand_int(MAX_EFFECT_INTERVAL_FRAMES);
    }

    // update active effects
    draw_effect_list();
    activeEffects = 0;
    for (u32 i = 0; i < CHAOS_END; i++) {
        if (effectTimers[i] > 0) {
            activeEffects++;
            effectData[i].func();
            effectTimers[i]--;
        }
    }
}