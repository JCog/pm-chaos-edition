#include "chaos.h"
#include "common.h"
#include "game_modes.h"
#include "dx/debug_menu.h"
#include "world/actions.h"

#define CHAOS_DEBUG 1

#define MAX_EFFECT_INTERVAL 15
#define MIN_EFFECT_LENGTH 10

#define MAX_EFFECT_INTERVAL_FRAMES (MAX_EFFECT_INTERVAL * 30)
#define MIN_EFFECT_LENGTH_FRAMES (MIN_EFFECT_LENGTH * 30)

struct EffectData {
    const char *name;
    b8 everyFrame;
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
static u8 selectedEffect = 0;
static u8 selectedTimer = 10;
#endif
b8 chaosSlowGo = FALSE;
b8 chaosTopDownCam = FALSE;
b8 chaosNegativeAttack = FALSE;
static f32 prevHeight = -10000.0f;
static u8 activeEffects = 0;
static u32 effectCountdown = 1;
static struct NpcScaleData npcScaleBuffer[] = {[0 ... MAX_NPCS] = {-1, {0, 0, 0}} };

static void perilSound() {
    if (frameCount % 25 == 0) {
        sfx_play_sound(SOUND_PERIL);
    }
}

static void posLoad() {
    static Vec3f savedPos;
    if (frameCount % 30 == 20) {
        savedPos = gPlayerStatus.pos;
    } else if (frameCount % 30 == 0) {
        gPlayerStatus.pos = savedPos;
    }
}

static void levitate() {
    Vec3f raycast = gPlayerStatus.pos;
    f32 rayLength = 10;
    player_raycast_down(&(raycast.x), &(raycast.y), &(raycast.z), &rayLength);
    if (rayLength < 10) {
        gPlayerStatus.pos.y = prevHeight = raycast.y + 10.0f;
    } else if (prevHeight < gPlayerStatus.pos.y) {
        prevHeight = gPlayerStatus.pos.y;
    } else {
        gPlayerStatus.pos.y = prevHeight;
    }

    gPlayerStatus.flags |= 1 << 1;
    gPlayerStatus.flags &= ~(1 << 2);
    gPlayerStatus.timeInAir = 1;
    gPlayerStatus.gravityIntegrator[0] = 0;
    gPlayerStatus.gravityIntegrator[1] = 0;
    gPlayerStatus.gravityIntegrator[2] = 0;
    gPlayerStatus.gravityIntegrator[3] = 0;

    if (gGameStatus.peachFlags & (1 << 0)) {
        PlayerActionsTable[5].flag = TRUE;
    }
}

static void levitateStop() {
    gPlayerStatus.gravityIntegrator[0] = 0.154342994094f;
    gPlayerStatus.gravityIntegrator[1] = -0.350080013275f;
    gPlayerStatus.gravityIntegrator[2] = -0.182262003422f;
    gPlayerStatus.gravityIntegrator[3] = 0.0115200001746f;
    prevHeight = -10000.0f;
}

static void magnetPosStep(Vec3f *pos, f32 speed) {
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

static void actorMagnet() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc != NULL) {
            magnetPosStep(&npc->pos, 2);
        }
    }
    for (u32 i = 0; i < MAX_ENTITIES; i++) {
        Entity *entity = (*gCurrentEntityListPtr)[i];
        if (entity != NULL) {
            magnetPosStep(&entity->pos, 2);
        }
    }
    for (u32 i = 0; i < MAX_ITEM_ENTITIES; i++) {
        ItemEntity *entity = (gCurrentItemEntities)[i];
        if (entity != NULL) {
            magnetPosStep(&entity->pos, 2);
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

static void squish() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc == NULL) {
            continue;
        }
        b8 existingData = FALSE;
        struct NpcScaleData *firstEmpty = NULL;
        for (u32 j = 0; j < MAX_NPCS; j++) {
            if (npcScaleBuffer[j].id == npc->npcID) {
                existingData = TRUE;
                break;
            } else if (npcScaleBuffer[j].id == -1){
                firstEmpty = &npcScaleBuffer[j];
                break;
            }
        }
        if (existingData) {
            npc->scale.x += 0.03f;
            npc->scale.z += 0.03f;
            npc->scale.y -= 0.0005f;
        } else if (firstEmpty != NULL) {
            firstEmpty->id = npc->npcID;
            firstEmpty->scale.x = npc->scale.x;
            firstEmpty->scale.z = npc->scale.z;
            firstEmpty->scale.y = npc->scale.y;
        }
    }
}

static void squishOff() {
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

static void negativeAttack() {
    chaosNegativeAttack = !chaosNegativeAttack;
}

struct EffectData effectData[] = {
    {"Peril Sound",     TRUE,   0,  45, perilSound,     NULL},
    {"Rewind",          TRUE,   0,  45, posLoad,        NULL},
    {"Levitate",        TRUE,   0,  10, levitate,       levitateStop},
    {"Actor Magnet",    TRUE,   0,  45, actorMagnet,    NULL},
    {"Knockback",       TRUE,   0,  45, knockback,      NULL},
    {"Lava",            FALSE,  0,  0,  lava,           NULL},
    {"Squish",          TRUE,   0,  45, squish,         squishOff},
    {"Slow Go",         FALSE,  0,  45, slowGo,         slowGo},
    {"Top-Down Cam",    FALSE,  0,  45, topDownCam,     topDownCam},
    {"Negative Attack", FALSE,  0,  45, negativeAttack, negativeAttack},
};

#define EFFECT_COUNT (ARRAY_COUNT(effectData))

static void drawEffectList() {
    #if DX_DEBUG_MENU
    if (dx_debug_menu_is_open()) {
        return;
    }
    #endif
    char fmtBuf[128];
    u8 index = 0;
    #if CHAOS_DEBUG
    sprintf(fmtBuf, "Selected: %ds - %d %s", selectedTimer, selectedEffect, effectData[selectedEffect].name);
    #else
    sprintf(fmtBuf, "Effect Countdown: %lu", effectCountdown / 30);
    #endif
    dx_debug_draw_ascii(fmtBuf, 0, 15, 55);
    for (u32 i = 0; i < EFFECT_COUNT; i++) {
        if (effectData[i].timer > 0) {
            if (effectData[i].maxSeconds == 0) {
                sprintf(fmtBuf, "%s", effectData[i].name);
            } else {
                sprintf(fmtBuf, "%s: %d", effectData[i].name, effectData[i].timer / 30);
            }
            dx_debug_draw_ascii(fmtBuf, 0, 15, 65 + index * 10);
            index++;
        }
    }
}

void chaosUpdate() {
    for (u32 i = 0; i < 10; i++) {
        if (get_game_mode() == badModes[i]) {
            return;
        }
    }
    frameCount = gPlayerData.frameCounter / 2;
    effectCountdown--;

    // select a new effect
    #if CHAOS_DEBUG
    s32 buttons = gGameStatus.pressedButtons[0];
    #if DX_DEBUG_MENU
    if (dx_debug_menu_is_open()) {
        buttons = 0;
    }
    #endif
    if (buttons & BUTTON_D_LEFT) {
        selectedEffect += EFFECT_COUNT - 1;
        selectedEffect %= EFFECT_COUNT;
    } else if (buttons & BUTTON_D_RIGHT) {
        selectedEffect++;
        selectedEffect %= EFFECT_COUNT;
    } else if (buttons & BUTTON_D_UP) {
        selectedTimer += 5;
    } else if (buttons & BUTTON_D_DOWN) {
        selectedTimer -= 5;
        if (selectedTimer < 0) {
            selectedTimer = 0;
        }
    } else if (buttons & BUTTON_R) {
        if (!effectData[selectedEffect].everyFrame) {
            effectData[selectedEffect].func();
        }
        if (effectData[selectedEffect].maxSeconds == 0) {
            effectData[selectedEffect].timer = 90;
        } else {
            effectData[selectedEffect].timer = selectedTimer * 30;
        }
    }
    #else
    if (effectCountdown == 0 && activeEffects < EFFECT_COUNT) {
        while (TRUE) {
            s32 id = rand_int(EFFECT_COUNT - 1);
            if (effectData[id].timer > 0) {
                continue;
            }

            if (!effectData[id].everyFrame) {
                effectData[id].func();
            }
            if (effectData[id].maxSeconds == 0) {
                effectData[id].timer = 90;
            } else {
                effectData[id].timer =
                    rand_int((effectData[id].maxSeconds - MIN_EFFECT_LENGTH) * 30) + MIN_EFFECT_LENGTH_FRAMES;
            }
            effectCountdown = rand_int(MAX_EFFECT_INTERVAL_FRAMES);
            break;
        }
    }
    #endif

    // update active effects
    drawEffectList();
    activeEffects = 0;
    for (u32 i = 0; i < EFFECT_COUNT; i++) {
        if (effectData[i].timer > 0) {
            activeEffects++;
            if (effectData[i].timer == 1 && effectData[i].off != NULL) {
                effectData[i].off();
            } else if (effectData[i].everyFrame){
                effectData[i].func();
            }
            effectData[i].timer--;
        }
    }
}