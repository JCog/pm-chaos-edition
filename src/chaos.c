#include "chaos.h"
#include "audio/public.h"
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

#if CHAOS_DEBUG
static u8 selectedEffect = 0;
static u8 selectedTimer = 10;
#endif

b8 chaosMenuOpen = FALSE;
static u32 effectCountdown = 1;
static b8 reloading = FALSE;
static u8 reloadDelay = 0;
static u16 reloadCooldown = 0;
static u16 reloadMessageTimer = 0;

static void chaosDrawBox(s32 posX, s32 posY, s32 sizeX, s32 sizeY, int style, s32 opacity) {
    draw_box(0, (WindowStyle)style, posX, posY, 0, sizeX, sizeY, opacity,
             0, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, NULL, 0, NULL, SCREEN_WIDTH, SCREEN_HEIGHT, NULL);
}

static void chaosDrawAscii(char *text, s32 color, s32 posX, s32 posY) {
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
        if (reloadCooldown > 0) {
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
        #if CHAOS_DEBUG
        if (i == 0) {
            continue;
        }
        #endif
        if (effectData[i].timer > 0) {
            activeEffects++;
        }
    }
    char fmtBuf[64];
    u8 index = 0;
    #if CHAOS_DEBUG
    if (randomEffects) {
        index++;
    }
    #endif
    chaosDrawBox(MENU_X, MENU_Y, MENU_WIDTH, MENU_HEIGHT_BASE + 10 * (activeEffects + index), WINDOW_STYLE_4, 192);
    #if CHAOS_DEBUG
    sprintf(fmtBuf, "-- %2ds - %2d %s --", selectedTimer, selectedEffect, effectData[selectedEffect].name);
    chaosDrawAscii(fmtBuf, 0, MENU_TEXT_X, MENU_TEXT_Y);
    if (randomEffects) {
        sprintf(fmtBuf, "%2lu", effectCountdown / 30);
        chaosDrawAscii("Chaos Timer", 0, MENU_TEXT_X, MENU_TEXT_Y + 10);
        chaosDrawAscii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y + 10);
    }
    #else
    sprintf(fmtBuf, "%2lu", effectCountdown / 30);
    chaosDrawAscii("Chaos Timer", 0, MENU_TEXT_X, MENU_TEXT_Y);
    chaosDrawAscii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y);
    #endif
    index++;
    for (s32 i = 0; i < totalEffectCount; i++) {
        #if CHAOS_DEBUG
        if (i == 0) {
            continue;
        }
        #endif
        if (effectData[i].timer > 0) {
            if (effectData[i].maxSeconds == 0) {
                sprintf(fmtBuf, "");
            } else {
                sprintf(fmtBuf, "%2d", effectData[i].timer / 30);
            }
            chaosDrawAscii(effectData[i].name, 0, MENU_TEXT_X, MENU_TEXT_Y + index * 10);
            chaosDrawAscii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y + index * 10);
            index++;
        }
    }
}

static void activateEffect(s32 effectId) {
    if (!effectData[effectId].everyFrame) {
        effectData[effectId].func();
    }
    if (effectData[effectId].maxSeconds == 0) {
        effectData[effectId].timer = 90;
    } else {
        #if CHAOS_DEBUG
        if (randomEffects) {
            effectData[effectId].timer =
                rand_int((effectData[effectId].maxSeconds - MIN_EFFECT_LENGTH) * 30) + MIN_EFFECT_LENGTH_FRAMES;
        } else {
            effectData[selectedEffect].timer = selectedTimer * 30;
        }
        #else
        effectData[effectId].timer =
            rand_int((effectData[effectId].maxSeconds - MIN_EFFECT_LENGTH) * 30) + MIN_EFFECT_LENGTH_FRAMES;
        #endif
    }
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
        chaosMenuOpen = !chaosMenuOpen;
        return;
    }
    #if CHAOS_DEBUG
    if (!chaosMenuOpen) {
        return;
    }
    if (held & BUTTON_D_LEFT) {
        selectedEffect += totalEffectCount - 1;
        selectedEffect %= totalEffectCount;
    } else if (held & BUTTON_D_RIGHT) {
        selectedEffect++;
        selectedEffect %= totalEffectCount;
    } else if (held & BUTTON_D_UP) {
        if (selectedEffect < 255) {
            selectedTimer += 5;
        }
    } else if (held & BUTTON_D_DOWN) {
        if (selectedTimer > 0) {
            selectedTimer -= 5;
        }
    } else if (pressed & BUTTON_R) {
        if (effectData[selectedEffect].canTrigger == NULL || effectData[selectedEffect].canTrigger()) {
            activateEffect(selectedEffect);
        }
    }
    #endif
}

void chaosUpdate() {
    for (s32 i = 0; i < 10; i++) {
        if (get_game_mode() == badModes[i]) {
            return;
        }
    }
    #if CHAOS_DEBUG
    if (randomEffects) {
        effectCountdown--;
    }
    #else
    effectCountdown--;
    #endif

    handleMenu();
    updateReload();
    handleBattleQueue();
    handleTimers();

    // select a new effect
    if (effectCountdown == 0) {
        // try 20 times to apply an effect, skip if a valid one can't be found
        for (s32 i = 0; i < 20; i++) {
            #if CHAOS_DEBUG
            s32 id = rand_int(totalEffectCount - 2) + 1;
            #else
            s32 id = rand_int(totalEffectCount - 1);
            #endif
            if (effectData[id].timer > 0 || (effectData[id].canTrigger != NULL && !effectData[id].canTrigger())) {
                continue;
            }
            activateEffect(id);
            effectCountdown = rand_int(MAX_EFFECT_INTERVAL_FRAMES);
            break;
        }
    }

    // update active effects
    for (s32 i = 0; i < totalEffectCount; i++) {
        b8 shouldTrigger = effectData[i].canTrigger == NULL || effectData[i].canTrigger();
        if (effectData[i].timer > 0 && (shouldTrigger || effectData[i].maxSeconds == 0)) {
            if (effectData[i].timer == 1 && effectData[i].off != NULL) {
                effectData[i].off();
            } else if (effectData[i].everyFrame){
                effectData[i].func();
            }
            effectData[i].timer--;
        }
    }

    if (chaosMenuOpen) {
        drawEffectList();
    }
}