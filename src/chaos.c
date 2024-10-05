#include "chaos.h"
#include "dx/debug_menu.h"
#include "dx/utils.h"
#include "game_modes.h"

#define MAX_EFFECT_INTERVAL 15
#define MIN_EFFECT_LENGTH 10
#define MAX_EFFECT_INTERVAL_FRAMES (MAX_EFFECT_INTERVAL * 30)
#define MIN_EFFECT_LENGTH_FRAMES (MIN_EFFECT_LENGTH * 30)

#if CHAOS_DEBUG
#define MENU_WIDTH 215
#else
#define MENU_WIDTH 160
#endif
#define MENU_HEIGHT_BASE 19
#define MENU_X 15
#define MENU_Y 56
#define MENU_TEXT_X (MENU_X + 5)
#define MENU_TEXT_Y (MENU_Y + 3)
#define MENU_TIMER_OFFSET (MENU_TEXT_X + 138)

#define RELOAD_COOLDOWN_TIME 60

const enum GameMode badModes[] = {
    GAME_MODE_STARTUP, GAME_MODE_LOGOS, GAME_MODE_TITLE_SCREEN, GAME_MODE_ENTER_DEMO_WORLD, GAME_MODE_ENTER_WORLD,
    GAME_MODE_GAME_OVER, GAME_MODE_FILE_SELECT, GAME_MODE_END_FILE_SELECT, GAME_MODE_INTRO, GAME_MODE_DEMO
};

static u8 menuEffect = 0;
static u8 menuTimer = 10;
static s32 effectCountdown = 2;
static b8 reloading = FALSE;
static u8 reloadDelay = 0;
static u16 reloadCooldown = 0;
static u16 reloadMessageTimer = 0;

static void chaosDrawBox(s32 posX, s32 posY, s32 sizeX, s32 sizeY, int style, s32 opacity) {
    draw_box(0, (WindowStyle)style, posX, posY, 0, sizeX, sizeY, opacity,
             0, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, NULL, 0, NULL, SCREEN_WIDTH, SCREEN_HEIGHT, NULL);
}

static void chaosDrawAscii(const char *text, s32 color, s32 posX, s32 posY) {
    char buf[128] = {
        MSG_CHAR_READ_FUNCTION, MSG_READ_FUNC_SIZE, 12, 12
    };
    dx_string_to_msg(&buf[4], text);
    draw_msg((s32)buf, posX, posY, 255, color, 0);
}

static void reloadRoom() {
    bgm_set_song(1, -1, 0, 0, 0); // clear secondary songs
    snd_ambient_stop_all(0);
    au_sfx_reset_player();
    disable_player_input();
    gGameStatus.exitTangent = 0;
    clear_windows();
    set_curtain_scale_goal(2.0f);
    set_curtain_draw_callback(NULL);
    set_curtain_fade_goal(0.0f);

    if (get_game_mode() == GAME_MODE_PAUSE) {
        reloadDelay = 5;
        set_game_mode(GAME_MODE_UNPAUSE);
    } else {
        reloadDelay = 0;
    }
    reloadCooldown = RELOAD_COOLDOWN_TIME * 30;
    reloading = TRUE;
}

static void updateReload() {
    if (reloadCooldown > 0) {
        reloadCooldown--;
    }
    if (reloadMessageTimer) {
        reloadMessageTimer--;
        chaosDrawAscii("Reload Cooldown Active", 0, 102, 80);
    }
    s32 cur = gGameStatus.curButtons[0];
    s32 pressed = gGameStatus.pressedButtons[0];
    if ((cur & BUTTON_R) && (pressed & BUTTON_D_DOWN)) {
        if (reloadCooldown > 0 && !CHAOS_DEBUG) {
            reloadMessageTimer = 90;
            return;
        }
        reloadRoom();
    }

    if (!reloading) {
        return;
    }
    if (reloadDelay > 0) {
        reloadDelay--;
        return;
    }
    set_map_transition_effect(TRANSITION_STANDARD);
    set_game_mode(GAME_MODE_CHANGE_MAP);
    reloading = FALSE;
}

static void drawEffectList() {
    #if DX_DEBUG_MENU
    if (dx_debug_menu_is_open()) {
        return;
    }
    #endif
    u8 activeEffects = 0;
    for (s32 i = 0; i < totalEffectCount; i++) {
        if (CHAOS_DEBUG && i == 0) {
            continue;
        }
        if (effectData[i].timer > 0) {
            activeEffects++;
        }
    }
    char fmtBuf[64];
    u8 index = 0;
    if (CHAOS_DEBUG && randomEffects) {
        index++;
    }
    chaosDrawBox(MENU_X, MENU_Y, MENU_WIDTH, MENU_HEIGHT_BASE + 10 * (activeEffects + index), WINDOW_STYLE_4, 192);
    if (CHAOS_DEBUG) {
        sprintf(fmtBuf, "-- %2ds - %2d %s --", menuTimer, menuEffect, effectData[menuEffect].name);
        chaosDrawAscii(fmtBuf, 0, MENU_TEXT_X, MENU_TEXT_Y);
        if (randomEffects) {
            sprintf(fmtBuf, "%2lu", effectCountdown / 30);
            chaosDrawAscii("Chaos Timer", 0, MENU_TEXT_X, MENU_TEXT_Y + 10);
            chaosDrawAscii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y + 10);
        }
    } else {
        sprintf(fmtBuf, "%2lu", effectCountdown / 30);
        chaosDrawAscii("Chaos Timer", 0, MENU_TEXT_X, MENU_TEXT_Y);
        chaosDrawAscii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y);
    }
    index++;
    for (s32 i = 0; i < totalEffectCount; i++) {
        if (CHAOS_DEBUG && i == 0) {
            continue;
        }
        ChaosEffectData *effect = &effectData[i];
        if (effect->timer > 0) {
            if (effect->maxSeconds == 0) {
                sprintf(fmtBuf, "");
            } else {
                sprintf(fmtBuf, "%2d", effect->timer / 30);
            }
            chaosDrawAscii(effect->name, 0, MENU_TEXT_X, MENU_TEXT_Y + index * 10);
            chaosDrawAscii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y + index * 10);
            index++;
        }
    }
}

static void activateEffect(s32 effectId) {
    ChaosEffectData *effect = &effectData[effectId];
    if (!effect->everyFrame) {
        effect->func(effect);
    }
    if (effect->maxSeconds == 0) {
        effect->timer = 90;
    } else {
        if (randomEffects) {
            effect->timer = rand_int((effect->maxSeconds - MIN_EFFECT_LENGTH) * 30) + MIN_EFFECT_LENGTH_FRAMES;
        } else {
            effect->timer = menuTimer * 30;
        }
    }
}

static b8 canTriggerEffect(ChaosEffectData *effect) {
    return effect->canTrigger == NULL || effect->canTrigger();
}

static void handleMenu() {
    #if DX_DEBUG_MENU
    if (dx_debug_menu_is_open()) {
        return;
    }
    #endif
    s32 pressed = gGameStatus.pressedButtons[0];
    s32 held = gGameStatus.heldButtons[0];
    if (pressed & BUTTON_L) {
        chaosStatus.menuOpen = !chaosStatus.menuOpen;
        return;
    }
    if (CHAOS_DEBUG) {
        if (!chaosStatus.menuOpen) {
            return;
        }
        if (held & BUTTON_D_LEFT) {
            menuEffect += totalEffectCount - 1;
            menuEffect %= totalEffectCount;
        } else if (held & BUTTON_D_RIGHT) {
            menuEffect++;
            menuEffect %= totalEffectCount;
        } else if (held & BUTTON_D_UP) {
            if (menuEffect < 255) {
                menuTimer += 5;
            }
        } else if (held & BUTTON_D_DOWN) {
            if (menuTimer > 0) {
                menuTimer -= 5;
            }
        } else if (pressed & BUTTON_R) {
            ChaosEffectData* effect = &effectData[menuEffect];
            if (effect->timer > 0 && effect->maxSeconds != 0) {
                effect->timer = 0;
                if (effect->off != NULL) {
                    effect->off(effect);
                }
            } else if (canTriggerEffect(effect)) {
                // prevent untoggling certain commands while they're active
                if (effect->timer > 0 && effect->maxSeconds > 0) {
                    effect->timer = menuTimer * 30;
                } else {
                    activateEffect(menuEffect);
                }
            }
        }
    }
}

void chaosUpdate() {
    for (s32 i = 0; i < 10; i++) {
        if (get_game_mode() == badModes[i]) {
            return;
        }
    }
    if (randomEffects) {
        effectCountdown--;
    }

    handleMenu();
    updateReload();
    handleBattleQueue();
    handleTimers();

    // select a new effect
    if (effectCountdown == 0) {
        // try 20 times to apply an effect, skip if a valid one can't be found
        for (s32 i = 0; i < 20; i++) {
            s32 id;
            if (CHAOS_DEBUG) {
                id = rand_int(totalEffectCount - 2) + 1;
            } else {
                id = rand_int(totalEffectCount - 1);
            }
            ChaosEffectData *effect = &effectData[id];
            if (effect->timer > 0 || !canTriggerEffect(effect)) {
                continue;
            }
            activateEffect(id);
            effectCountdown = rand_int(MAX_EFFECT_INTERVAL_FRAMES) + 1;
            break;
        }
    }

    // update active effects
    for (s32 i = 0; i < totalEffectCount; i++) {
        ChaosEffectData *effect = &effectData[i];
        // also updates timer for instantaneous effects
        if (effect->timer > 0 && (canTriggerEffect(effect) || effect->maxSeconds == 0)) {
            if (effect->timer == 1 && effect->off != NULL) {
                effect->off(effect);
            } else if (effect->everyFrame){
                effect->func(effect);
            }
            effect->timer--;
        }
    }

    if (chaosStatus.menuOpen) {
        drawEffectList();
    }
}