#include "chaos.h"
#include "common.h"
#include "game_modes.h"
#include "dx/debug_menu.h"
#include "world/actions.h"

#define CHAOS_DEBUG 1

#define NAMESPACE chaos

#define MAX_EFFECT_INTERVAL 15
#define MIN_EFFECT_LENGTH 10
#define MAX_EFFECT_INTERVAL_FRAMES (MAX_EFFECT_INTERVAL * 30)
#define MIN_EFFECT_LENGTH_FRAMES (MIN_EFFECT_LENGTH * 30)

#define MENU_WIDTH 220
#define MENU_HEIGHT_BASE 19
#define MENU_X 15
#define MENU_Y 23
#define MENU_TEXT_X (MENU_X + 5)
#define MENU_TEXT_Y (MENU_Y + 3)
#define MENU_TIMER_OFFSET (MENU_TEXT_X + 100)

#define RELOAD_COOLDOWN_TIME 60

struct ChaosEffectData {
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
b8 chaosMenuOpen = FALSE;
b8 chaosSlowGo = FALSE;
b8 chaosTopDownCam = FALSE;
b8 chaosHealingTouch = FALSE;
b8 chaosAllSfxAttackFx = FALSE;
static f32 prevHeight = -10000.0f;
static u8 activeEffects = 0;
static u32 effectCountdown = 1;
static b8 reloading = FALSE;
static u8 reloadDelay = 0;
static u16 reloadCooldown = 0;
static u16 reloadMessageTimer = 0;
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

static void magnetPosStep(Vec3f *pos) {
    f32 speed = 3;
    Vec3f marioPos = gPlayerStatus.pos;
    if (dist3D(marioPos.x, marioPos.y, marioPos.z, pos->x, pos->y, pos->z) <= speed) {
        return;
    }
    f32 xDiff = marioPos.x - pos->x;
    f32 yDiff = marioPos.y - pos->y;
    f32 zDiff = marioPos.z - pos->z;
    f32 temp = speed / sqrtf(SQ(xDiff) + SQ(yDiff) + SQ(zDiff));
    pos->x += temp * xDiff;
    pos->y += temp * yDiff;
    pos->z += temp * zDiff;
}

static void actorMagnet() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc != NULL) {
            magnetPosStep(&npc->pos);
        }
    }
    for (u32 i = 0; i < MAX_ENTITIES; i++) {
        Entity *entity = (*gCurrentEntityListPtr)[i];
        if (entity != NULL) {
            magnetPosStep(&entity->pos);
        }
    }
    for (u32 i = 0; i < MAX_ITEM_ENTITIES; i++) {
        ItemEntity *entity = (gCurrentItemEntities)[i];
        if (entity != NULL) {
            magnetPosStep(&entity->pos);
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
    chaosHealingTouch = !chaosHealingTouch;
}

API_CALLABLE(GetRandTattleId) {
    s32 idA;
    s32 idB;
    s32 tattle = rand_int(100);
    if (tattle < 45) {
        idA = 0x19;
        idB = rand_int(0x188);
    } else if (tattle < 78) {
        idA = 0x1A;
        idB = rand_int(0x121);
    } else if (tattle < 88) {
        idA = 0x1B;
        idB = rand_int(0x25);
    } else {
        idA = 0x1C;
        idB = rand_int(0x95);
    }
    script->varTable[0] = MESSAGE_ID(idA, idB);

    return ApiStatus_DONE2;
}


EvtScript N(EVS_Random_Tattle) = {
    Call(GetRandTattleId)
    Call(ShowMessageAtScreenPos, LVar0, 160, 40)
    Return
    End
};

static void randomTattle() {
    start_script(&N(EVS_Random_Tattle), EVT_PRIORITY_A, 0);
}

static void intangibleEnemies() {
    gGameStatus.debugEnemyContact = !gGameStatus.debugEnemyContact;
}

static void allSfxAttackFx() {
    chaosAllSfxAttackFx = !chaosAllSfxAttackFx;
}

static void addRemoveCoins() {
    s32 coins = rand_int(99) + 1;
    if (rand_int(1)) {
        coins *= -1;
    }
    add_coins(coins);
    sfx_play_sound(SOUND_COIN_PICKUP);
    open_status_bar_quickly();
}

static void addRemoveStarPoints() {
    s32 sp = rand_int(49) + 1;
    if (rand_int(1)) {
        sp *= -1;
    }
    gPlayerData.starPoints += sp;
    if (gPlayerData.starPoints > 99) {
        gPlayerData.starPoints = 99;
    } else if (gPlayerData.starPoints < 0) {
        gPlayerData.starPoints = 0;
    }
    sfx_play_sound(SOUND_STAR_POINT_PICKUP);
    open_status_bar_quickly();
    if (!gGameStatus.isBattle) {
        status_bar_start_blinking_starpoints();
    }
}

struct ChaosEffectData effectData[] = {
    {"Peril Sound",             TRUE,   0,  45, perilSound,             NULL},
    {"Rewind",                  TRUE,   0,  45, posLoad,                NULL},
    {"Levitate",                TRUE,   0,  10, levitate,               levitateStop},
    {"Actor Chase",             TRUE,   0,  45, actorMagnet,            NULL},
    {"Knockback",               TRUE,   0,  45, knockback,              NULL},
    {"Lava",                    FALSE,  0,  0,  lava,                   NULL},
    {"Squish",                  TRUE,   0,  45, squish,                 squishOff},
    {"Slow Go",                 FALSE,  0,  45, slowGo,                 slowGo},
    {"Top-Down Cam",            FALSE,  0,  45, topDownCam,             topDownCam},
    {"Healing Touch",           FALSE,  0,  45, negativeAttack,         negativeAttack},
    {"Random Tattle",           FALSE,  0,  0,  randomTattle,           NULL},
    {"Intangible Enemies",      FALSE,  0,  45, intangibleEnemies,      intangibleEnemies},
    {"All SFX AttackFX",        FALSE,  0,  45, allSfxAttackFx,         allSfxAttackFx},
    {"Add/Remove Coins",        FALSE,  0,  0,  addRemoveCoins,         NULL},
    {"Add/Remove Star Points",  FALSE,  0,  0,  addRemoveStarPoints,    NULL},
};

#define EFFECT_COUNT (ARRAY_COUNT(effectData))

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
        dx_debug_draw_ascii("Reload Cooldown Active", 0, 102, 80);
    }
    s32 held = gGameStatus.curButtons[0];
    s32 pressed = gGameStatus.pressedButtons[0];
    if ((held & BUTTON_R) && (pressed & BUTTON_D_DOWN)) {
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
    char fmtBuf[64];
    u8 index = 0;
    dx_debug_draw_box(MENU_X, MENU_Y, MENU_WIDTH, MENU_HEIGHT_BASE + 10 * activeEffects, WINDOW_STYLE_4, 192);
    #if CHAOS_DEBUG
    sprintf(fmtBuf, "Selected: %ds - %d %s", selectedTimer, selectedEffect, effectData[selectedEffect].name);
    dx_debug_draw_ascii(fmtBuf, 0, MENU_TEXT_X, MENU_TEXT_Y);
    #else
    sprintf(fmtBuf, "%lu", effectCountdown / 30);
    dx_debug_draw_ascii("Chaos Timer", 0, MENU_TEXT_X, MENU_TEXT_Y);
    dx_debug_draw_ascii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y);
    #endif
    for (u32 i = 0; i < EFFECT_COUNT; i++) {
        if (effectData[i].timer > 0) {
            if (effectData[i].maxSeconds == 0) {
                sprintf(fmtBuf, "");
            } else {
                sprintf(fmtBuf, "%d", effectData[i].timer / 30);
            }
            dx_debug_draw_ascii(effectData[i].name, 0, MENU_TEXT_X, MENU_TEXT_Y + 10 + index * 10);
            dx_debug_draw_ascii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y + 10 + index * 10);
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
        effectData[selectedEffect].timer = selectedTimer * 30;
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
    s32 buttons = gGameStatus.pressedButtons[0];
    if (buttons & BUTTON_L) {
        chaosMenuOpen = !chaosMenuOpen;
        return;
    }
    #if CHAOS_DEBUG
    if (!chaosMenuOpen) {
        return;
    }
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
        activateEffect(selectedEffect);
    }
    #endif
}

void chaosUpdate() {
    for (u32 i = 0; i < 10; i++) {
        if (get_game_mode() == badModes[i]) {
            return;
        }
    }
    frameCount = gPlayerData.frameCounter / 2;
    effectCountdown--;

    handleMenu();
    updateReload();

    // select a new effect
    #if !CHAOS_DEBUG
    if (effectCountdown == 0 && activeEffects < EFFECT_COUNT) {
        while (TRUE) {
            s32 id = rand_int(EFFECT_COUNT - 1);
            if (effectData[id].timer > 0) {
                continue;
            }
            activateEffect(id);
            effectCountdown = rand_int(MAX_EFFECT_INTERVAL_FRAMES);
            break;
        }
    }
    #endif

    // update active effects
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

    if (chaosMenuOpen) {
        drawEffectList();
    }
}