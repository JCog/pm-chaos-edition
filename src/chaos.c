#include "chaos.h"
#include "common.h"
#include "dx/debug_menu.h"
#include "effects.h"
#include "game_modes.h"
#include "script_api/battle.h"
#include "world/actions.h"

#define CHAOS_DEBUG TRUE

#define NAMESPACE chaos

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

#define ACTOR_DATA_COUNT 64

struct ChaosEffectData {
    const char *name;
    b8 everyFrame;
    s16 timer;
    s8 maxSeconds;
    void (*func)();
    void (*off)();
    b8 (*canTrigger)();
};

enum ActorType {
    ACTOR_NPC,
    ACTOR_ENEMY,
    ACTOR_BATTLE_PARTNER,
};

struct ActorScaleData {
    s16 id;
    enum ActorType actorType;
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
b8 chaosHideModels = FALSE;
b8 chaosSpinAngle = FALSE;
b8 chaosHpSoundPlayed = FALSE;
b8 chaosFpSoundPlayed = FALSE;
static f32 prevHeight = -10000.0f;
static u32 effectCountdown = 1;
static b8 reloading = FALSE;
static u8 reloadDelay = 0;
static u16 reloadCooldown = 0;
static u16 reloadMessageTimer = 0;
static s8 hpSoundTimer = 0;
static s8 fpSoundTimer = 0;
static struct ActorScaleData actorScaleBuffer[] = {[0 ... ACTOR_DATA_COUNT] = {-1, 0, {0, 0, 0}} };

static b8 isOverworld() {
    return !gGameStatus.isBattle;
}

static b8 isBattle() {
    return gGameStatus.isBattle;
}

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

static void squishActor(s8 id, enum ActorType actorType, Vec3f *scale) {
    b8 existingData = FALSE;
    struct ActorScaleData *firstEmpty = NULL;
    for (u32 i = 0; i < ACTOR_DATA_COUNT; i++) {
        if (actorScaleBuffer[i].id == id && actorScaleBuffer[i].actorType == actorType) {
            existingData = TRUE;
            break;
        } else if (actorScaleBuffer[i].id == -1){
            firstEmpty = &actorScaleBuffer[i];
            break;
        }
    }
    if (existingData) {
        scale->x += 0.03f;
        scale->z += 0.03f;
        scale->y -= 0.0005f;
    } else if (firstEmpty != NULL) {
        firstEmpty->id = id;
        firstEmpty->actorType = actorType;
        firstEmpty->scale.x = scale->x;
        firstEmpty->scale.z = scale->z;
        firstEmpty->scale.y = scale->y;
    }
}

static void squish() {
    for (u32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc == NULL) {
            continue;
        }
        squishActor(npc->npcID, ACTOR_NPC, &npc->scale);
    }
    for (u32 i = 0; i < MAX_ENEMY_ACTORS; i++) {
        Actor *enemy = gBattleStatus.enemyActors[i];
        if (enemy == NULL) {
            continue;
        }
        squishActor(i, ACTOR_ENEMY, &enemy->scale);
    }
    if (gBattleStatus.partnerActor != NULL) {
        squishActor(gBattleStatus.partnerActor->actorID, ACTOR_BATTLE_PARTNER, &gBattleStatus.partnerActor->scale);
    }
}

static void squishOff() {
    for (u32 i = 0; i < ACTOR_DATA_COUNT; i++) {
        if (actorScaleBuffer[i].id == -1) {
            continue;
        }
        switch (actorScaleBuffer[i].actorType) {
            case ACTOR_NPC: {
                Npc *npc = get_npc_safe(actorScaleBuffer[i].id);
                if (npc != NULL) {
                    npc->scale.x = actorScaleBuffer[i].scale.x;
                    npc->scale.z = actorScaleBuffer[i].scale.z;
                    npc->scale.y = actorScaleBuffer[i].scale.y;
                }
                break;
            }
            case ACTOR_ENEMY: {
                Actor *enemy = gBattleStatus.enemyActors[actorScaleBuffer[i].id];
                if (enemy != NULL) {
                    enemy->scale.x = actorScaleBuffer[i].scale.x;
                    enemy->scale.z = actorScaleBuffer[i].scale.z;
                    enemy->scale.y = actorScaleBuffer[i].scale.y;
                }
                break;
            }
            case ACTOR_BATTLE_PARTNER: {
                gBattleStatus.partnerActor->scale.x = actorScaleBuffer[i].scale.x;
                gBattleStatus.partnerActor->scale.z = actorScaleBuffer[i].scale.z;
                gBattleStatus.partnerActor->scale.y = actorScaleBuffer[i].scale.y;
            }
        }
        actorScaleBuffer[i].id = -1;
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

static b8 canUnequipBadge() {
    for (u32 i = 0; i < 64; i++) {
        if (gPlayerData.equippedBadges[i] != 0) {
            return TRUE;
        }
    }
    return FALSE;
}

static void unequipBadge() {
    s32 eqBadgeCount = 0;
    for (u32 i = 0; i < 64; i++) {
        if (gPlayerData.equippedBadges[i] == 0) {
            break;
        } else {
            eqBadgeCount++;
        }
    }
    if (eqBadgeCount == 0) {
        return;
    }

    sfx_play_sound(SOUND_MENU_BADGE_UNEQUIP);
    if (eqBadgeCount == 1) {
        gPlayerData.equippedBadges[0] = 0;
    } else {
        // prevent gaps in the array
        s32 badgeIndex = rand_int(eqBadgeCount - 1);
        gPlayerData.equippedBadges[badgeIndex] = gPlayerData.equippedBadges[eqBadgeCount - 1];
        gPlayerData.equippedBadges[eqBadgeCount - 1] = 0;
    }
}

static void hideModels() {
    chaosHideModels = !chaosHideModels;
}

static void spinAngle() {
    chaosSpinAngle = !chaosSpinAngle;
}

static b8 actorAtHome(Actor *actor) {
    // actors can dance around, so checking in a range
    if (fabsf(actor->homePos.x - actor->curPos.x) > 20) {
        return FALSE;
    }
    if (fabsf(actor->homePos.y - actor->curPos.y) > 20) {
        return FALSE;
    }
    if (fabsf(actor->homePos.z - actor->curPos.z) > 20) {
        return FALSE;
    }
    return TRUE;
}

EvtScript N(EVS_Shuffle_Sparkles) = {
    Call(PlaySound, SOUND_MULTIPLE_STAR_SPIRITS_APPEAR)
    Call(GetActorPos, ACTOR_PLAYER, LVar0, LVar1, LVar2)
    Add(LVar1, 15)
    PlayEffect(EFFECT_SPARKLES, 0, LVar0, LVar1, LVar2, 10)
    IfEq(LVar4, TRUE)
        Call(GetActorPos, ACTOR_PARTNER, LVar0, LVar1, LVar2)
        Add(LVar1, 15)
        PlayEffect(EFFECT_SPARKLES, 0, LVar0, LVar1, LVar2, 10)
    EndIf
    Set(LVar3, ACTOR_ENEMY0)
    Loop(LVar5)
        Call(GetActorPos, LVar3, LVar0, LVar1, LVar2)
        Add(LVar1, 15)
        PlayEffect(EFFECT_SPARKLES, 0, LVar0, LVar1, LVar2, 10)
        Add(LVar3, 1)
    EndLoop
    Return
    End
};

static void shuffleBattlePos() {
    Actor *actors[26];
    b8 atHome[26];
    u8 actorIdx = 0;
    actors[actorIdx] = gBattleStatus.playerActor;
    atHome[actorIdx++] = actorAtHome(gBattleStatus.playerActor);
    if (gBattleStatus.partnerActor != NULL) {
        actors[actorIdx] = gBattleStatus.partnerActor;
        atHome[actorIdx++] = actorAtHome(gBattleStatus.partnerActor);
    }
    for (u32 i = 0; i < MAX_ENEMY_ACTORS; i++) {
        if (gBattleStatus.enemyActors[i] != NULL) {
            actors[actorIdx] = gBattleStatus.enemyActors[i];
            atHome[actorIdx++] = actorAtHome(gBattleStatus.partnerActor);
        }
    }

    // shuffle positions
    u8 actorCount = actorIdx--;
    Vec3f oldPos[26];
    Vec3s oldHealth[26];
    Vec3f newPos[26];
    Vec3s newHealth[26];
    for (u32 i = 0; i < actorCount; i++) {
        oldPos[i] = actors[i]->homePos;
        oldHealth[i] = actors[i]->healthBarPos;
    }
    for (u32 i = 0; i < actorCount; i++) {
        u8 oldIdx = rand_int(actorIdx);
        newPos[i] = oldPos[oldIdx];
        newHealth[i] = oldHealth[oldIdx];
        oldPos[oldIdx] = oldPos[actorIdx];
        oldHealth[oldIdx] = oldHealth[actorIdx--];
    }

    // apply new position homes, move them if they're not away from their current home (aka probably attacking)
    for (u32 i = 0; i < actorCount; i++) {
        actors[i]->homePos.x = newPos[i].x;
        actors[i]->homePos.z = newPos[i].z;
        actors[i]->healthBarPos.x = newPos[i].x;
        actors[i]->healthBarPos.z = newPos[i].z;
        if (atHome[i]) {
            actors[i]->curPos.x = newPos[i].x;
            actors[i]->curPos.z = newPos[i].z;
        }
    }
    Evt *script = start_script(&N(EVS_Shuffle_Sparkles), EVT_PRIORITY_A, 0);
    script->varTable[4] = gBattleStatus.partnerActor != NULL;
    script->varTable[5] = actorCount - 2;
}

static void randomHp() {
    s8 oldHp = gPlayerData.curHP;
    while (gPlayerData.curHP == oldHp) {
        gPlayerData.curHP = rand_int(gPlayerData.curMaxHP - 1) + 1;
    }
    chaosHpSoundPlayed = FALSE;
    hpSoundTimer = 20;
}

static void randomFp() {
    s8 oldFp = gPlayerData.curFP;
    while (gPlayerData.curFP == oldFp) {
        gPlayerData.curFP = rand_int(gPlayerData.curMaxFP);
    }
    chaosFpSoundPlayed = FALSE;
    fpSoundTimer = 20;
}

static b8 canPointSwap() {
    return gPlayerData.curHP != gPlayerData.curFP;
}

static void pointSwap() {
    s8 curHpTemp = gPlayerData.curHP;
    gPlayerData.curHP = gPlayerData.curFP;
    gPlayerData.curFP = curHpTemp;
    // intentionally allowing this to set your HP to 0, should be stable -- will change if proven otherwise
    if (gPlayerData.curHP > gPlayerData.curMaxHP) {
        gPlayerData.curHP = gPlayerData.curMaxHP;
    }
    if (gPlayerData.curFP > gPlayerData.curMaxFP) {
        gPlayerData.curFP = gPlayerData.curMaxFP;
    }
    sfx_play_sound(SOUND_JUMP_COMBO_8);
    chaosHpSoundPlayed = FALSE;
    chaosFpSoundPlayed = FALSE;
    hpSoundTimer = 20;
    fpSoundTimer = 20;
}

struct ChaosEffectData effectData[] = {
    {"Rewind",                  TRUE,   0,  45, posLoad,                NULL,               isOverworld},
    {"Levitate",                TRUE,   0,  10, levitate,               levitateStop,       isOverworld},
    {"Actor Chase",             TRUE,   0,  45, actorMagnet,            NULL,               isOverworld},
    {"Knockback",               TRUE,   0,  45, knockback,              NULL,               isOverworld},
    {"Slow Go",                 FALSE,  0,  45, slowGo,                 slowGo,             isOverworld},
    {"Top-Down Cam",            FALSE,  0,  45, topDownCam,             topDownCam,         isOverworld},
    {"Intangible Enemies",      FALSE,  0,  45, intangibleEnemies,      intangibleEnemies,  isOverworld},
    {"Random Spin Angle",       FALSE,  0,  45, spinAngle,              spinAngle,          isOverworld},
    {"Lava",                    FALSE,  0,  0,  lava,                   NULL,               isOverworld},
    {"Healing Touch",           FALSE,  0,  45, negativeAttack,         negativeAttack,     isBattle},
    {"Location Shuffle",        FALSE,  0,  0,  shuffleBattlePos,       NULL,               isBattle},
    {"Unequip Badge",           FALSE,  0,  0,  unequipBadge,           NULL,               canUnequipBadge},
    {"Point Swap",              FALSE,  0,  0,  pointSwap,              NULL,               canPointSwap},
    {"Peril Sound",             TRUE,   0,  45, perilSound,             NULL,               NULL},
    {"Squish",                  TRUE,   0,  45, squish,                 squishOff,          NULL},
    {"All SFX AttackFX",        FALSE,  0,  45, allSfxAttackFx,         allSfxAttackFx,     NULL},
    {"Hide Models",             FALSE,  0,  45, hideModels,             hideModels,         NULL},
    {"Random HP",               FALSE,  0,  0,  randomHp,               NULL,               NULL},
    {"Random FP",               FALSE,  0,  0,  randomFp,               NULL,               NULL},
    {"Add/Remove Coins",        FALSE,  0,  0,  addRemoveCoins,         NULL,               NULL},
    {"Add/Remove Star Points",  FALSE,  0,  0,  addRemoveStarPoints,    NULL,               NULL},
    {"Random Tattle",           FALSE,  0,  0,  randomTattle,           NULL,               NULL},
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

static void handleSoundTimers() {
    if (hpSoundTimer >= 0) {
        hpSoundTimer--;
    }
    if (fpSoundTimer >= 0) {
        fpSoundTimer--;
    }
    if (hpSoundTimer == 0 && !chaosHpSoundPlayed) {
        sfx_play_sound(SOUND_HEART_PICKUP);
    }
    if (fpSoundTimer == 0 && !chaosFpSoundPlayed) {
        sfx_play_sound(SOUND_FLOWER_PICKUP);
    }
}

static void drawEffectList() {
    #if DX_DEBUG_MENU
    if (dx_debug_menu_is_open()) {
        return;
    }
    #endif
    u8 activeEffects = 0;
    for (u32 i = 0; i < EFFECT_COUNT; i++) {
        if (effectData[i].timer > 0) {
            activeEffects++;
        }
    }
    char fmtBuf[64];
    u8 index = 0;
    dx_debug_draw_box(MENU_X, MENU_Y, MENU_WIDTH, MENU_HEIGHT_BASE + 10 * activeEffects, WINDOW_STYLE_4, 192);
    #if CHAOS_DEBUG
    sprintf(fmtBuf, "-- %2ds - %2d %s --", selectedTimer, selectedEffect, effectData[selectedEffect].name);
    dx_debug_draw_ascii(fmtBuf, 0, MENU_TEXT_X, MENU_TEXT_Y);
    #else
    sprintf(fmtBuf, "%2lu", effectCountdown / 30);
    dx_debug_draw_ascii("Chaos Timer", 0, MENU_TEXT_X, MENU_TEXT_Y);
    dx_debug_draw_ascii(fmtBuf, 0, MENU_TIMER_OFFSET, MENU_TEXT_Y);
    #endif
    for (u32 i = 0; i < EFFECT_COUNT; i++) {
        if (effectData[i].timer > 0) {
            if (effectData[i].maxSeconds == 0) {
                sprintf(fmtBuf, "");
            } else {
                sprintf(fmtBuf, "%2d", effectData[i].timer / 30);
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
        if (selectedEffect < 255) {
            selectedTimer += 5;
        }
    } else if (buttons & BUTTON_D_DOWN) {
        if (selectedTimer > 0) {
            selectedTimer -= 5;
        }
    } else if (buttons & BUTTON_R) {
        if (effectData[selectedEffect].canTrigger == NULL || effectData[selectedEffect].canTrigger()) {
            activateEffect(selectedEffect);
        }
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
    handleSoundTimers();

    // select a new effect
    #if !CHAOS_DEBUG
    if (effectCountdown == 0) {
        // try 20 times to apply an effect, skip if a valid one can't be found
        for (u32 i = 0; i < 20; i++) {
            s32 id = rand_int(EFFECT_COUNT - 1);
            if (effectData[id].timer > 0 || (effectData[id].canTrigger != NULL && !effectData[id].canTrigger())) {
                continue;
            }
            activateEffect(id);
            effectCountdown = rand_int(MAX_EFFECT_INTERVAL_FRAMES);
            break;
        }
    }
    #endif

    // update active effects
    for (u32 i = 0; i < EFFECT_COUNT; i++) {
        if (effectData[i].timer > 0 && (effectData[i].canTrigger == NULL || effectData[i].canTrigger())) {
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