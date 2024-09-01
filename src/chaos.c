#include "chaos.h"
#include "common.h"
#include "game_modes.h"
#include "dx/debug_menu.h"
#include "world/actions.h"

enum EffectData {
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

struct ChaosEffect {
    const char *name;
    enum EffectType type;
    u16 seconds;
    void (*func)();
};

u32 frameCount = 0;
s16 effectTimers[CHAOS_END];
const enum GameMode badModes[] = {
    GAME_MODE_STARTUP, GAME_MODE_LOGOS, GAME_MODE_TITLE_SCREEN, GAME_MODE_ENTER_DEMO_WORLD, GAME_MODE_ENTER_WORLD,
    GAME_MODE_GAME_OVER, GAME_MODE_FILE_SELECT, GAME_MODE_END_FILE_SELECT, GAME_MODE_INTRO, GAME_MODE_DEMO
};

#define EFFECT_INTERVAL 15
#define EFFECT_MAX 10
static activeEffects = 0;

void peril_sound() {
    if (frameCount % 25 == 0) {
        sfx_play_sound(SOUND_PERIL);
    }
}

void pos_load() {
    static Vec3f saved_pos;
    if (frameCount % 30 == 20) {
        saved_pos = gPlayerStatus.pos;
    } else if (frameCount % 30 == 0) {
        gPlayerStatus.pos = saved_pos;
    }
}

void levitate() {
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

void actor_magnet() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc != NULL) {
            if (gPlayerStatus.pos.x - npc->pos.x > 2) {
                npc->pos.x += 2;
            } else if (gPlayerStatus.pos.x - npc->pos.x < 2) {
                npc->pos.x -= 2;
            }
            if (gPlayerStatus.pos.y - npc->pos.y > 2) {
                npc->pos.y += 2;
            } else if (gPlayerStatus.pos.y - npc->pos.y < 2) {
                npc->pos.y -= 2;
            }
            if (gPlayerStatus.pos.z - npc->pos.z > 2) {
                npc->pos.z += 2;
            } else if (gPlayerStatus.pos.z - npc->pos.z < 2) {
                npc->pos.z -= 2;
            }
        }
    }
    for (u32 i = 0; i < MAX_ENTITIES; i++) {
        Entity *entity = (*gCurrentEntityListPtr)[i];
        if (entity != NULL) {
            if (gPlayerStatus.pos.x - entity->pos.x > 2) {
                entity->pos.x += 2;
            } else if (gPlayerStatus.pos.x - entity->pos.x < 2) {
                entity->pos.x -= 2;
            }
            if (gPlayerStatus.pos.y - entity->pos.y > 2) {
                entity->pos.y += 2;
            } else if (gPlayerStatus.pos.y - entity->pos.y < 2) {
                entity->pos.y -= 2;
            }
            if (gPlayerStatus.pos.z - entity->pos.z > 2) {
                entity->pos.z += 2;
            } else if (gPlayerStatus.pos.z - entity->pos.z < 2) {
                entity->pos.z -= 2;
            }
        }
    }
    for (u32 i = 0; i < MAX_ITEM_ENTITIES; i++) {
        ItemEntity *entity = (gCurrentItemEntities)[i];
        if (entity != NULL) {
            if (gPlayerStatus.pos.x - entity->pos.x > 2) {
                entity->pos.x += 2;
            } else if (gPlayerStatus.pos.x - entity->pos.x < 2) {
                entity->pos.x -= 2;
            }
            if (gPlayerStatus.pos.y - entity->pos.y > 2) {
                entity->pos.y += 2;
            } else if (gPlayerStatus.pos.y - entity->pos.y < 2) {
                entity->pos.y -= 2;
            }
            if (gPlayerStatus.pos.z - entity->pos.z > 2) {
                entity->pos.z += 2;
            } else if (gPlayerStatus.pos.z - entity->pos.z < 2) {
                entity->pos.z -= 2;
            }
        }
    }
}

void knockback() {
    if (frameCount % 60 == 0) {
        set_action_state(ACTION_STATE_KNOCKBACK);
    }
}

void lava() {
    set_action_state(ACTION_STATE_HIT_LAVA);
}

void wide() {
    NpcList *npcList = gCurrentNpcListPtr;
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*npcList)[i];
        if (npc != NULL) {
            npc->scale.x = 4;
            npc->scale.y = 0.5;
        }
    }
}

struct ChaosEffect effectData[CHAOS_END] = {
    {"Peril Sound",     CHAOS_CONTINUOUS, 15, peril_sound},
    {"Rewind",          CHAOS_CONTINUOUS, 30, pos_load},
    {"Levitate",        CHAOS_CONTINUOUS, 10, levitate},
    {"Actor Magnet",    CHAOS_CONTINUOUS, 20, actor_magnet},
    {"Knockback",       CHAOS_CONTINUOUS, 30, knockback},
    {"Lava",            CHAOS_INSTANT,    0,  lava},
    {"Wide",            CHAOS_INSTANT,    0,  wide},
};

void draw_effect_list() {
    char fmtBuf[128];
    u8 index = 0;
    for (u32 i = 0; i < CHAOS_END; i++) {
        if (effectTimers[i] > 0) {
            sprintf(fmtBuf, "%s: %d", effectData[i].name, effectTimers[i] / 30);
            dx_debug_draw_ascii(fmtBuf, 0, 15, 55 + index * 10);
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

    // select a new effect
    if (activeEffects == 0 || (activeEffects < EFFECT_MAX && frameCount % (EFFECT_INTERVAL * 30) == 0)) {
        s32 newEffect = rand_int(CHAOS_END - 1);
        if (effectData[newEffect].type == CHAOS_INSTANT) {
            effectData[newEffect].func();
        } else if (effectTimers[newEffect] == 0) {
            effectTimers[newEffect] = 30 * effectData[newEffect].seconds;
        }
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