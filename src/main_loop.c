#include "common.h"
#include "nu/nusys.h"
#include "ld_addrs.h"
#include "hud_element.h"
#include "sprite.h"
#include "overlay.h"
#include "game_modes.h"
#include "dx/profiling.h"
#include "dx/debug_menu.h"
#include "dx/utils.h"
#include "world/actions.h"

s32 gOverrideFlags;
s32 timeFreezeMode;
u16** nuGfxCfb;
BSS s16 SoftResetDelay;

DisplayContext DisplayContexts[2];

s8 gGameStepDelayAmount = 1;
s8 gGameStepDelayCount = 5;

GameStatus gGameStatus = {
    .curButtons = { 0 },
    .pressedButtons = { 0 },
    .heldButtons = { 0 },
    .prevButtons = { 0 },
    .stickX = { 0 },
    .stickY = { 0 },
    .unk_48 = { 0 },
    .unk_50 = { 0 },
};

GameStatus* gGameStatusPtr = &gGameStatus;
s16 SoftResetOverlayAlpha = 0;
s16 SoftResetState = 0;
s32 D_800741A4 = 0;

Mtx MasterIdentityMtx = RDP_MATRIX(
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000
);

s32 D_800741E8[2] = {0, 0}; // padding?
u16 gMatrixListPos = 0;
u16 D_800741F2 = 0;
s32 gCurrentDisplayContextIndex = 0;
s32 gPauseBackgroundFade = 0;
s32 D_800741FC = 0;

void gfx_init_state(void);

void gfx_draw_background(void);

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
    NpcList *npcList = getNpcListPtr();
    EntityList *entityList = getEntityListPtr();
    ItemEntity **itemList = getItemEntityListPtr();
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*npcList)[i];
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
        Entity *entity = (*entityList)[i];
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
    for (u32 i = 0; i < MAX_ENTITIES; i++) {
        Entity *entity = (*entityList)[i];
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
        ItemEntity *entity = (itemList)[i];
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
    NpcList *npcList = getNpcListPtr();
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

void update_chaos(void) {
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

void step_game_loop(void) {
    profiler_frame_setup();

    PlayerData* playerData = &gPlayerData;
    const int MAX_GAME_TIME = 1000*60*60*60 - 1; // 1000 hours minus one frame at 60 fps

#if !VERSION_JP
    update_input();
    profiler_update(PROFILER_TIME_CONTROLLERS, 0);
#endif

    gGameStatusPtr->frameCounter++;

    playerData->frameCounter += 2;
    if (playerData->frameCounter > MAX_GAME_TIME) {
        playerData->frameCounter = MAX_GAME_TIME;
    }

#if VERSION_JP
    update_input();
    profiler_update(PROFILER_TIME_CONTROLLERS, 0);
#endif

    update_max_rumble_duration();

    if (gGameStepDelayCount != 0) {
        gGameStepDelayCount-- ;
        if (gGameStepDelayCount == 0) {
            gGameStepDelayCount = gGameStepDelayAmount;
        } else {
            return;
        }
    }

    mdl_reset_transform_flags();
    update_workers();
    profiler_update(PROFILER_TIME_WORKERS, 0);
    update_triggers();
    profiler_update(PROFILER_TIME_TRIGGERS, 0);
    update_scripts();
    profiler_update(PROFILER_TIME_EVT, 0);
    update_messages();
    profiler_update(PROFILER_TIME_MESSAGES, 0);
    update_hud_elements();
    profiler_update(PROFILER_TIME_HUD_ELEMENTS, 0);
    step_game_mode();
    profiler_update(PROFILER_TIME_STEP_GAME_MODE, 0);
    update_entities();
    profiler_update(PROFILER_TIME_ENTITIES, 0);
    func_80138198();
    bgm_update_music_settings();
    update_ambient_sounds();
    sfx_update_env_sound_params();
    update_windows();
    update_curtains();

    if (gOverrideFlags & GLOBAL_OVERRIDES_SOFT_RESET) {
        switch (SoftResetState) {
            case 0:
                gOverrideFlags |= GLOBAL_OVERRIDES_200;
                disable_player_input();

                if (SoftResetOverlayAlpha == 255) {
                    SoftResetState = 1;
                    SoftResetDelay = 3;
                } else {
                    SoftResetOverlayAlpha += 10;
                    if (SoftResetOverlayAlpha > 255) {
                        SoftResetOverlayAlpha = 255;
                    }
                }
                break;
            case 1:
                gOverrideFlags |= GLOBAL_OVERRIDES_DISABLE_DRAW_FRAME;
                SoftResetDelay--;
                if (SoftResetDelay == 0) {
                    sfx_stop_env_sounds();
                    set_game_mode(GAME_MODE_STARTUP);
                    gOverrideFlags &= ~GLOBAL_OVERRIDES_SOFT_RESET;
                }
                break;
        }
    } else {
        SoftResetOverlayAlpha = 0;
        SoftResetState = 0;
    }

    if (gOverrideFlags & GLOBAL_OVERRIDES_DISABLE_BATTLES) {
        gOverrideFlags |= GLOBAL_OVERRIDES_PREV_DISABLE_BATTLES;
    } else {
        gOverrideFlags &= ~GLOBAL_OVERRIDES_PREV_DISABLE_BATTLES;
    }

    if (gOverrideFlags & GLOBAL_OVERRIDES_200) {
        gOverrideFlags |= GLOBAL_OVERRIDES_PREV_200;
    } else {
        gOverrideFlags &= ~GLOBAL_OVERRIDES_PREV_200;
    }

    if (gOverrideFlags & GLOBAL_OVERRIDES_400) {
        gOverrideFlags |= GLOBAL_OVERRIDES_PREV_400;
    } else {
        gOverrideFlags &= ~GLOBAL_OVERRIDES_PREV_400;
    }

    if (gOverrideFlags & GLOBAL_OVERRIDES_800) {
        gOverrideFlags |= GLOBAL_OVERRIDES_PREV_800;
    } else {
        gOverrideFlags &= ~GLOBAL_OVERRIDES_PREV_800;
    }

    // Unused rand_int used to advance the global random seed each visual frame
    rand_int(1);
}

void gfx_task_background(void) {
    gDisplayContext = &DisplayContexts[gCurrentDisplayContextIndex];
    gMainGfxPos = &gDisplayContext->backgroundGfx[0];

    gfx_init_state();
    gfx_draw_background();

    gDPFullSync(gMainGfxPos++);
    gSPEndDisplayList(gMainGfxPos++);

    // TODO these << 3 >> 3 shouldn't be necessary. There's almost definitely something we're missing here...
    ASSERT((s32)((u32)((gMainGfxPos - gDisplayContext->backgroundGfx) << 3) >> 3) < ARRAY_COUNT(
               gDisplayContext->backgroundGfx))

    nuGfxTaskStart(&gDisplayContext->backgroundGfx[0], (u32)(gMainGfxPos - gDisplayContext->backgroundGfx) * 8,
                   NU_GFX_UCODE_F3DEX2, NU_SC_NOSWAPBUFFER);
}

void gfx_draw_frame(void) {
    profiler_gfx_started();

    gMatrixListPos = 0;
    gMainGfxPos = &gDisplayContext->mainGfx[0];

    if (gOverrideFlags & GLOBAL_OVERRIDES_DISABLE_DRAW_FRAME) {
        gCurrentDisplayContextIndex = gCurrentDisplayContextIndex ^ 1;
        return;
    }

    gSPMatrix(gMainGfxPos++, &MasterIdentityMtx, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);

    spr_render_init();

    GFX_PROFILER_COMPLETE(PROFILER_TIME_SUB_GFX_UPDATE); // dummy

    if (!(gOverrideFlags & GLOBAL_OVERRIDES_DISABLE_RENDER_WORLD)) {
        render_frame(FALSE);
    }

    player_render_interact_prompts();
    func_802C3EE4();

    GFX_PROFILER_SWITCH(PROFILER_TIME_SUB_GFX_HUD_ELEMENTS, PROFILER_TIME_SUB_GFX_BACK_UI);
    render_screen_overlay_backUI();
    render_workers_backUI();
    render_hud_elements_backUI();
    render_effects_UI();
    render_game_mode_backUI();

    if (!(gOverrideFlags & GLOBAL_OVERRIDES_WINDOWS_OVER_CURTAINS)) {
        render_window_root();
    }

    GFX_PROFILER_SWITCH(PROFILER_TIME_SUB_GFX_BACK_UI, PROFILER_TIME_SUB_GFX_FRONT_UI);

    if (!(gOverrideFlags & GLOBAL_OVERRIDES_DISABLE_RENDER_WORLD) && gGameStatusPtr->debugScripts == DEBUG_SCRIPTS_NONE) {
        render_frame(TRUE);
    }

    if (!(gOverrideFlags & GLOBAL_OVERRIDES_MESSAGES_OVER_CURTAINS)
        && !(gOverrideFlags & GLOBAL_OVERRIDES_MESSAGES_OVER_FRONTUI)
    ) {
        render_messages();
    }

    render_workers_frontUI();
    render_hud_elements_frontUI();
    render_screen_overlay_frontUI();

    if (!(gOverrideFlags & GLOBAL_OVERRIDES_MESSAGES_OVER_CURTAINS)
        && (gOverrideFlags & GLOBAL_OVERRIDES_MESSAGES_OVER_FRONTUI)
    ) {
        render_messages();
    }

    render_curtains();

    if (gOverrideFlags & GLOBAL_OVERRIDES_MESSAGES_OVER_CURTAINS) {
        render_messages();
    }

    if (gOverrideFlags & GLOBAL_OVERRIDES_WINDOWS_OVER_CURTAINS) {
        render_window_root();
    }

    render_game_mode_frontUI();

    if (gOverrideFlags & GLOBAL_OVERRIDES_SOFT_RESET) {
        switch (SoftResetState) {
            case 0:
            case 1:
                _render_transition_stencil(OVERLAY_SCREEN_MARIO, SoftResetOverlayAlpha, NULL);
                break;
        }
    }

    GFX_PROFILER_COMPLETE(PROFILER_TIME_SUB_GFX_FRONT_UI);

    profiler_gfx_completed();
    profiler_print_times();

    #if DX_DEBUG_MENU
    dx_debug_console_main();
    #endif
    update_chaos();

    ASSERT((s32)(((u32)(gMainGfxPos - gDisplayContext->mainGfx) << 3) >> 3) < ARRAY_COUNT(gDisplayContext->mainGfx));

    gDPFullSync(gMainGfxPos++);
    gSPEndDisplayList(gMainGfxPos++);

    nuGfxTaskStart(gDisplayContext->mainGfx, (u32)(gMainGfxPos - gDisplayContext->mainGfx) * 8, NU_GFX_UCODE_F3DEX2,
                   NU_SC_TASK_LODABLE | NU_SC_SWAPBUFFER);
    gCurrentDisplayContextIndex = gCurrentDisplayContextIndex ^ 1;
    crash_screen_set_draw_info(nuGfxCfb_ptr, SCREEN_WIDTH, SCREEN_HEIGHT);
}

void load_engine_data(void) {
    s32 i;

    DMA_COPY_SEGMENT(engine4);
    DMA_COPY_SEGMENT(engine1);
    DMA_COPY_SEGMENT(evt);
    DMA_COPY_SEGMENT(entity);
    DMA_COPY_SEGMENT(engine2);
    DMA_COPY_SEGMENT(font_width);

    gOverrideFlags = 0;
    gGameStatusPtr->unk_79 = 0;
    gGameStatusPtr->backgroundFlags = 0;
    gGameStatusPtr->musicEnabled = TRUE;
    gGameStatusPtr->healthBarsEnabled = TRUE;
    gGameStatusPtr->introPart = INTRO_PART_NONE;
    gGameStatusPtr->demoBattleFlags = 0;
    gGameStatusPtr->multiplayerEnabled = FALSE;
    gGameStatusPtr->altViewportOffset.x = -8;
    gGameStatusPtr->altViewportOffset.y = 4;
    timeFreezeMode = 0;
    gGameStatusPtr->debugQuizmo = gGameStatusPtr->unk_13C = 0;
    gGameStepDelayCount = 5;
    gGameStatusPtr->saveCount = 0;
    fio_init_flash();
    func_80028838();
    general_heap_create();
    clear_render_tasks();
    clear_worker_list();
    clear_script_list();
    create_cameras_a();
    clear_player_status();
    spr_init_sprites(PLAYER_SPRITES_MARIO_WORLD);
    clear_entity_models();
    clear_animator_list();
    clear_model_data();
    clear_sprite_shading_data();
    reset_background_settings();
    clear_character_set();
    clear_printers();
    clear_game_mode();
    clear_npcs();
    hud_element_clear_cache();
    clear_trigger_data();
    clear_entity_data(FALSE);
    clear_player_data();
    init_encounter_status();
    clear_screen_overlays();
    clear_effect_data();
    clear_saved_variables();
    clear_item_entity_data();
    bgm_reset_sequence_players();
    reset_ambient_sounds();
    sfx_clear_sounds();
    clear_windows();
    initialize_curtains();
    poll_rumble();

    for (i = 0; i < ARRAY_COUNT(gGameStatusPtr->unk_50); i++) {
        gGameStatusPtr->unk_50[i] = 3;
        gGameStatusPtr->unk_48[i] = 12;
    }

    gOverrideFlags |= GLOBAL_OVERRIDES_DISABLE_DRAW_FRAME;
    set_game_mode(GAME_MODE_STARTUP);
}

/// Time freeze modes:
///  0: normal
///  1: NPCs move, can't be interacted with
///  2: NPCs don't move, no partner ability, can't interact, can't use exits
///  3: NPCs don't more or animate
///  4: NPCs can move, animations don't update, can use exits
void set_time_freeze_mode(s32 mode) {
    switch (mode) {
        case TIME_FREEZE_NORMAL:
            timeFreezeMode = mode;
            gOverrideFlags &= ~(GLOBAL_OVERRIDES_800 | GLOBAL_OVERRIDES_400 | GLOBAL_OVERRIDES_200 | GLOBAL_OVERRIDES_DISABLE_BATTLES);
            resume_all_group(EVT_GROUP_01 | EVT_GROUP_02);
            break;
        case TIME_FREEZE_PARTIAL:
            timeFreezeMode = mode;
            gOverrideFlags &= ~(GLOBAL_OVERRIDES_800 | GLOBAL_OVERRIDES_400 | GLOBAL_OVERRIDES_200);
            gOverrideFlags |= GLOBAL_OVERRIDES_DISABLE_BATTLES;
            suspend_all_group(EVT_GROUP_01);
            break;
        case TIME_FREEZE_FULL:
            timeFreezeMode = mode;
            gOverrideFlags &= ~(GLOBAL_OVERRIDES_400 | GLOBAL_OVERRIDES_800);
            gOverrideFlags |= GLOBAL_OVERRIDES_200 | GLOBAL_OVERRIDES_DISABLE_BATTLES;
            suspend_all_group(EVT_GROUP_02);
            break;
        case TIME_FREEZE_POPUP_MENU:
            timeFreezeMode = mode;
            gOverrideFlags &= ~GLOBAL_OVERRIDES_800;
            gOverrideFlags |= GLOBAL_OVERRIDES_400 | GLOBAL_OVERRIDES_200 | GLOBAL_OVERRIDES_DISABLE_BATTLES;
            suspend_all_group(EVT_GROUP_02);
            break;
        case TIME_FREEZE_EXIT:
            timeFreezeMode = mode;
            gOverrideFlags |= GLOBAL_OVERRIDES_800 | GLOBAL_OVERRIDES_400 | GLOBAL_OVERRIDES_200 | GLOBAL_OVERRIDES_DISABLE_BATTLES;
            break;
    }
}

s32 get_time_freeze_mode(void) {
    return timeFreezeMode;
}

#if VERSION_IQUE
static const f32 rodata_padding[] = {0.0f, 0.0f};
#endif
