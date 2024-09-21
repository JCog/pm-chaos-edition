#include "chaos.h"
#include "dx/config.h"
#include "game_modes.h"
#include "gcc/memory.h"
#include "inventory.h"
#include "script_api/battle.h"
#include "world/actions.h"

#define TIMER_DISABLED -32768
#define ACTOR_DATA_COUNT 64
#define FB_SIZE (SCREEN_WIDTH * SCREEN_HEIGHT * 2)

typedef enum ActorType {
    ACTOR_NPC,
    ACTOR_ENEMY,
    ACTOR_BATTLE_PARTNER,
} ActorType;

typedef struct ActorScaleData {
    s16 id;
    ActorType actorType;
    Vec3f originalScale;
    Vec3f curScale;
} ActorScaleData;

// conditionals
static b8 isOverworld(void);
static b8 canKnockback(void);
static b8 canTouchLava(void);
static b8 isValidBattle(void);
static b8 canEquipBadge(void);
static b8 canUnequipBadge(void);
static b8 canPointSwap(void);
static b8 hasMushroom(void);
static b8 canRememberThis(void);

#if CHAOS_DEBUG
static void toggleRandomEffects(ChaosEffectData*);
#endif
// overworld
static void posRewind(ChaosEffectData*);
static void posRewindOff(ChaosEffectData*);
static void levitate(ChaosEffectData*);
static void levitateOff(ChaosEffectData*);
static void actorChase(ChaosEffectData*);
static void knockback(ChaosEffectData*);
static void knockbackOff(ChaosEffectData*);
static void slowGo(ChaosEffectData*);
static void topDownCam(ChaosEffectData*);
static void intangibleEnemies(ChaosEffectData*);
static void spinAngle(ChaosEffectData*);
static void lava(ChaosEffectData*);
static void rotateMario(ChaosEffectData*);
static void rotateMarioOff(ChaosEffectData*);
// battle
static void negativeAttack(ChaosEffectData*);
static void randomEnemyHp(ChaosEffectData*);
static void shuffleBattlePos(ChaosEffectData*);
static void randomMarioMove(ChaosEffectData*);
// anywhere
static void equipBadge(ChaosEffectData*);
static void unequipBadge(ChaosEffectData*);
static void perilSound(ChaosEffectData*);
static void perilSoundOff(ChaosEffectData*);
static void squish(ChaosEffectData*);
static void squishOff(ChaosEffectData*);
static void allSfxAttackFx(ChaosEffectData*);
static void hideModels(ChaosEffectData*);
static void pointSwap(ChaosEffectData*);
static void randomHp(ChaosEffectData*);
static void randomFp(ChaosEffectData*);
static void addRemoveCoins(ChaosEffectData*);
static void addRemoveStarPoints(ChaosEffectData*);
static void randomTattle(ChaosEffectData*);
static void badMusic(ChaosEffectData*);
static void badMusicOff(ChaosEffectData*);
static void expireMushroom(ChaosEffectData*);
static void rotateCamera(ChaosEffectData*);
static void rotateCameraOff(ChaosEffectData*);
static void corruptBg(ChaosEffectData*);
static void corruptBgOff(ChaosEffectData*);
static void reverseAnalog(ChaosEffectData*);
static void shuffleButtons(ChaosEffectData*);
static void shuffleButtonsOff(ChaosEffectData*);
static void rememberThis(ChaosEffectData*);

ChaosEffectData effectData[] = {
    #if CHAOS_DEBUG
    {"Toggle Random Effects",   FALSE,  0,  0,  toggleRandomEffects,    NULL,               NULL},
    #endif
    // overworld
    {"Rewind",                  TRUE,   0,  60, posRewind,              posRewindOff,       isOverworld},
    {"Levitate",                TRUE,   0,  20, levitate,               levitateOff,        isOverworld},
    {"Actor Chase",             TRUE,   0,  20, actorChase,             NULL,               isOverworld},
    {"Knockback",               TRUE,   0,  60, knockback,              knockbackOff,       canKnockback},
    {"Slow Go",                 FALSE,  0,  60, slowGo,                 slowGo,             isOverworld},
    {"Top-Down Cam",            FALSE,  0,  60, topDownCam,             topDownCam,         isOverworld},
    {"Intangible Enemies",      FALSE,  0,  30, intangibleEnemies,      intangibleEnemies,  isOverworld},
    {"Random Spin Angle",       FALSE,  0,  60, spinAngle,              spinAngle,          isOverworld},
    {"The Floor is Lava",       FALSE,  0,  0,  lava,                   NULL,               canTouchLava},
    {"Rotate Mario",            TRUE,   0,  60, rotateMario,            rotateMarioOff,     isOverworld},
    // battle
    {"Healing Touch",           FALSE,  0,  10, negativeAttack,         negativeAttack,     isValidBattle},
    {"Random Enemy HP",         FALSE,  0,  0,  randomEnemyHp,          NULL,               isValidBattle},
    {"Location Shuffle",        FALSE,  0,  0,  shuffleBattlePos,       NULL,               isValidBattle},
    {"Random Mario Move",       FALSE,  0,  0,  randomMarioMove,        NULL,               isValidBattle},
    // anywhere
    {"Equip Badge",             FALSE,  0,  0,  equipBadge,             NULL,               canEquipBadge},
    {"Unequip Badge",           FALSE,  0,  0,  unequipBadge,           NULL,               canUnequipBadge},
    {"Peril Sound",             TRUE,   0,  30, perilSound,             perilSoundOff,      NULL},
    {"Squish",                  TRUE,   0,  60, squish,                 squishOff,          NULL},
    {"All SFX AttackFX",        FALSE,  0,  30, allSfxAttackFx,         allSfxAttackFx,     NULL},
    {"Hide Models",             FALSE,  0,  90, hideModels,             hideModels,         NULL},
    {"Point Swap",              FALSE,  0,  0,  pointSwap,              NULL,               canPointSwap},
    {"Random HP",               FALSE,  0,  0,  randomHp,               NULL,               NULL},
    {"Random FP",               FALSE,  0,  0,  randomFp,               NULL,               NULL},
    {"Add/Remove Coins",        FALSE,  0,  0,  addRemoveCoins,         NULL,               NULL},
    {"Add/Remove Star Points",  FALSE,  0,  0,  addRemoveStarPoints,    NULL,               NULL},
    {"Random Tattle",           FALSE,  0,  0,  randomTattle,           NULL,               NULL},
    {"Bad Music",               TRUE,   0,  90, badMusic,               badMusicOff,        NULL},
    {"Mushroom Expires",        FALSE,  0,  0,  expireMushroom,         NULL,               hasMushroom},
    {"Rotate Camera",           FALSE,  0,  90, rotateCamera,           rotateCameraOff,    NULL},
    {"Corrupt Background",      TRUE,   0,  90, corruptBg,              corruptBgOff,       NULL},
    {"Reverse Analog Stick",    FALSE,  0,  90, reverseAnalog,          reverseAnalog,      NULL},
    {"Shuffle Buttons",         FALSE,  0,  90, shuffleButtons,         shuffleButtonsOff,  NULL},
    {"Remember This?",          FALSE,  0,  0,  rememberThis,           NULL,               canRememberThis},
};

const u8 totalEffectCount = ARRAY_COUNT(effectData);
b8 randomEffects = !CHAOS_DEBUG;

s16 chaosTimers[TIMER_MAX] = {0};
b8 chaosLevitating = FALSE;
b8 chaosSlowGo = FALSE;
b8 chaosTopDownCam = FALSE;
b8 chaosHealingTouch = FALSE;
b8 chaosAllSfxAttackFx = FALSE;
b8 chaosHideModels = FALSE;
b8 chaosSpinAngle = FALSE;
b8 chaosHpSoundPlayed = FALSE;
b8 chaosFpSoundPlayed = FALSE;
b8 chaosBadMusic = FALSE;
b8 chaosRotateCamera = FALSE;
Matrix4f chaosRotateMtx = {0};
b8 chaosBackgroundChanged = TRUE;
b8 chaosRotating = FALSE;
b8 chaosReverseAnalog = FALSE;
b8 chaosShuffleButtons = FALSE;
enum Buttons chaosButtonMap[9] = {0};
b8 chaosRememberThis = FALSE;

static b8 rewindSaved = FALSE;
static s16 rewindTime = TIMER_DISABLED;
static Vec3f rewindPos;
static s16 knockbackTime = TIMER_DISABLED;
static b8 battleQueueMario = FALSE;
static s16 enemyHpDeltas[ARRAY_COUNT(gBattleStatus.enemyActors)];
static s16 perilTime = TIMER_DISABLED;
static ActorScaleData actorScaleBuffer[] = {[0 ... ACTOR_DATA_COUNT] = {-1, 0, {0, 0, 0}} };
static u16 savedPalette[256];
static BackgroundHeader bgSaved = {.palette = &savedPalette[0]};
static f32 marioFlipYaw = 0.0f;
static f32 marioPitch = 0.0f;
static f32 marioSpriteFacingAngle = 0.0f;
static f32 yawSpeed = 0.0f;
static f32 pitchSpeed = 0.0f;
static u16 *chaosSavedFrame = NULL;

const enum ItemIDs mushroomIds[] = {
    ITEM_MUSHROOM, ITEM_VOLT_SHROOM, ITEM_SUPER_SHROOM, ITEM_ULTRA_SHROOM, ITEM_LIFE_SHROOM, ITEM_HONEY_SHROOM,
    ITEM_MAPLE_SHROOM, ITEM_JELLY_SHROOM
};

static void updateEnemyHpDeltas() {
    b8 hpUpdated = FALSE;
    for (s32 i = 0; i < ARRAY_COUNT(gBattleStatus.enemyActors); i++) {
        Actor *enemy = gBattleStatus.enemyActors[i];
        s16 *hpDelta = &enemyHpDeltas[i];
        if (enemy == NULL || *hpDelta == 0) {
            continue;
        }
        s16 diff = *hpDelta > 0 ? 1 : -1;
        enemy->curHP += diff;
        *hpDelta -= diff;
        hpUpdated = TRUE;
    }
    if (hpUpdated) {
        sfx_play_sound(SOUND_HEART_PICKUP);
        chaosTimers[TIMER_ENEMY_HP_UPDATE] += 4;
    }
}

void handleTimers() {
    for (s32 i = 0; i < TIMER_MAX; i++) {
        if (chaosTimers[i] >= 0) {
            chaosTimers[i]--;
        }
    }

    if (chaosTimers[TIMER_ENEMY_HP_UPDATE] == 30) {
        updateEnemyHpDeltas();
    }
    if (chaosTimers[TIMER_HP_SOUND] == 0 && !chaosHpSoundPlayed) {
        sfx_play_sound(SOUND_HEART_PICKUP);
    }
    if (chaosTimers[TIMER_FP_SOUND] == 0 && !chaosFpSoundPlayed) {
        sfx_play_sound(SOUND_FLOWER_PICKUP);
    }
    if (chaosTimers[TIMER_REMEMBER_THIS] == 130) {
        chaosRememberThis = TRUE;
        osViSwapBuffer(chaosSavedFrame);
        bgm_push_song(SONG_ITEM_UPGRADE, 1);
    } else if (chaosTimers[TIMER_REMEMBER_THIS] == 0) {
        chaosRememberThis = FALSE;
        bgm_pop_song();
    }
}

static b8 isMovePossible(u8 moveId, MoveData *move) {
    if ((move->category == MOVE_TYPE_STAR_POWER && move->costFP > gPlayerData.starPower / 0x100)
        || (move->category != MOVE_TYPE_STAR_POWER && move->costFP > gPlayerData.curFP)
        || (move->category == MOVE_TYPE_JUMP && (gPlayerData.bootsLevel < 0 || gBattleStatus.jumpLossTurns > 0))
        || (move->category == MOVE_TYPE_HAMMER && (gPlayerData.hammerLevel < 0 || gBattleStatus.hammerLossTurns > 0)))
    {
        return FALSE;
    }
    Actor *player = gBattleStatus.playerActor;
    if (move->category == MOVE_TYPE_JUMP) {
        gBattleStatus.moveCategory = BTL_MENU_TYPE_JUMP;
        gBattleStatus.moveArgument = gPlayerData.bootsLevel;
    } else if (move->category == MOVE_TYPE_HAMMER) {
        gBattleStatus.moveCategory = BTL_MENU_TYPE_SMASH;
        gBattleStatus.moveArgument = gPlayerData.hammerLevel;
    } else if (move->category == MOVE_TYPE_STAR_POWER) {
        if (moveId == MOVE_FOCUS) {
            return gPlayerData.maxStarPower > 0;
        }
        if (moveId == MOVE_STAR_BEAM) {
            return gPlayerData.starBeamLevel == 1;
        }
        if (moveId == MOVE_PEACH_BEAM) {
            return gPlayerData.starBeamLevel == 2;
        }
        gBattleStatus.moveCategory = BTL_MENU_TYPE_STAR_POWERS;
        gBattleStatus.moveArgument = moveId;
    }
    gBattleStatus.curTargetListFlags = move->flags;
    create_current_pos_target_list(player);
    return player->targetListLength > 0;
}

static b8 isBattleItemUsable(s16 itemId) {
    if (itemId == ITEM_NONE) {
        return FALSE;
    }

    ItemData *itemData = &gItemTable[itemId];
    if (!(itemData->typeFlags & ITEM_TYPE_FLAG_BATTLE_USABLE)) {
        return FALSE;
    }

    Actor *player = gBattleStatus.playerActor;
    gBattleStatus.moveCategory = BTL_MENU_TYPE_ITEMS;
    gBattleStatus.moveArgument = itemId;
    gBattleStatus.curTargetListFlags = itemData->targetFlags;
    create_current_pos_target_list(player);
    return player->targetListLength > 0;
}



void handleBattleQueue() {
    if (!isValidBattle()) {
        battleQueueMario = FALSE;
        return;
    }
    if (!battleQueueMario || (gBattleState != BATTLE_STATE_PLAYER_MENU && gBattleState != BATTLE_STATE_SELECT_TARGET)) {
        return;
    }

    enum MoveType moveTypes[] = {
        MOVE_TYPE_JUMP, MOVE_TYPE_HAMMER, MOVE_TYPE_STAR_POWER, MOVE_TYPE_ITEMS, MOVE_TYPE_NONE
    };
    enum MoveType moveType;
    while (TRUE) {
        moveType = moveTypes[rand_int(ARRAY_COUNT(moveTypes) - 1)];
        b8 validType = FALSE;
        switch (moveType) {
            case MOVE_TYPE_JUMP:
                // jump logic is simple - if you can't do a normal jump, you can't do any other jump move
                validType = isMovePossible(MOVE_JUMP1, &gMoveTable[MOVE_JUMP1]);
                break;
            case MOVE_TYPE_HAMMER:
                // hammer logic isn't simple - e.g. you might be able to hammer throw but not hammer
                validType = isMovePossible(MOVE_HAMMER1, &gMoveTable[MOVE_HAMMER1]);
                if (validType) {
                    break;
                }
                for (s32 j = 0; j < ARRAY_COUNT(gPlayerData.equippedBadges); j++) {
                    s16 badge = gPlayerData.equippedBadges[j];
                    if (badge == ITEM_NONE) {
                        continue;
                    }

                    u8 moveId = gItemTable[badge].moveID;
                    MoveData *move = &gMoveTable[moveId];
                    if (move->category != MOVE_TYPE_HAMMER) {
                        continue;
                    }

                    if (isMovePossible(moveId, move)) {
                        validType = TRUE;
                        break;
                    }
                }
                break;
            case MOVE_TYPE_STAR_POWER:
                // focus being possible is logically sufficient here
                validType = isMovePossible(MOVE_FOCUS, &gMoveTable[MOVE_FOCUS]);
                break;
            case MOVE_TYPE_ITEMS:
                for (s32 j = 0; j < ARRAY_COUNT(gPlayerData.invItems); j++) {
                    if (isBattleItemUsable(gPlayerData.invItems[j])) {
                        validType = TRUE;
                        break;
                    }
                }
                break;
            default:
                // strategies can always at least do nothing
                validType = TRUE;
                break;
        }
        if (validType) {
            break;
        }
    }

    s16 moveChoices[24] = {0};
    u8 moveCount = 0;

    // check regular jump and hammer
    if (moveType == MOVE_TYPE_JUMP && isMovePossible(MOVE_JUMP1, &gMoveTable[MOVE_JUMP1])) {
        moveChoices[moveCount++] = MOVE_JUMP1 + gPlayerData.bootsLevel;
    }
    if (moveType == MOVE_TYPE_HAMMER && isMovePossible(MOVE_HAMMER1, &gMoveTable[MOVE_HAMMER1])) {
        moveChoices[moveCount++] = MOVE_HAMMER1 + gPlayerData.hammerLevel;
    }

    // check for badge moves
    if (moveType == MOVE_TYPE_JUMP || moveType == MOVE_TYPE_HAMMER) {
        for (s32 i = 0; i < ARRAY_COUNT(gPlayerData.equippedBadges); i++) {
            s16 badge = gPlayerData.equippedBadges[i];
            if (badge == ITEM_NONE) {
                continue;
            }

            u8 moveId = gItemTable[badge].moveID;
            MoveData *move = &gMoveTable[moveId];
            if (move->category != moveType) {
                continue;
            }

            if (isMovePossible(moveId, move)) {
                moveChoices[moveCount++] = moveId;
            }
        }
    }

    // check for star power
    if (moveType == MOVE_TYPE_STAR_POWER) {
        if (isMovePossible(MOVE_FOCUS, &gMoveTable[MOVE_FOCUS])) {
            moveChoices[moveCount++] = MOVE_FOCUS;
        }
        if (isMovePossible(MOVE_STAR_BEAM, &gMoveTable[MOVE_STAR_BEAM])) {
            moveChoices[moveCount++] = MOVE_STAR_BEAM;
        } else if (isMovePossible(MOVE_PEACH_BEAM, &gMoveTable[MOVE_PEACH_BEAM])) {
            moveChoices[moveCount++] = MOVE_PEACH_BEAM;
        }
        for (s32 i = 0; i < 7; i++) {
            if (isMovePossible(MOVE_REFRESH + i, &gMoveTable[MOVE_REFRESH + i])) {
                moveChoices[moveCount++] = MOVE_REFRESH + i;
            }
        }
    }

    // check for items
    if (moveType == MOVE_TYPE_ITEMS) {
        for (s32 i = 0; i < ARRAY_COUNT(gPlayerData.invItems); i++) {
            if (isBattleItemUsable(gPlayerData.invItems[i])) {
                moveChoices[moveCount++] = gPlayerData.invItems[i];
            }
        }
    }

    // check for strategies
    if (moveType == MOVE_TYPE_NONE) {
        u8 strategyCount = 0;
        enum BattleMenuTypes strategyTypes[3] = {0};
        enum BattleMenuTypes strategy;

        strategyTypes[strategyCount++] = BTL_MENU_TYPE_DO_NOTHING;

        if (!gCurrentEncounter.forbidFleeing) {
            strategyTypes[strategyCount++] = BTL_MENU_TYPE_RUN_AWAY;
        }

        Actor *partner = gBattleStatus.partnerActor;
        if (partner->koStatus != STATUS_KEY_DAZE && partner->debuff != STATUS_KEY_FROZEN) {
            u8 partnersEnabled = 0;
            for (s32 j = 0; j < ARRAY_COUNT(gPlayerData.partners); j++) {
                if (gPlayerData.partners[j].enabled) {
                    partnersEnabled++;
                }
            }
            if (partnersEnabled >= 2) {
                strategyTypes[strategyCount++] = BTL_MENU_TYPE_CHANGE_PARTNER;
            }
        }

        strategy = strategyTypes[rand_int(strategyCount - 1)];
        switch(strategy) {
            case BTL_MENU_TYPE_DO_NOTHING:
                clear_windows();
                btl_set_state(BATTLE_STATE_END_PLAYER_TURN);
                return;
            case BTL_MENU_TYPE_RUN_AWAY:
                clear_windows();
                gBattleStatus.moveCategory = BTL_MENU_TYPE_RUN_AWAY;
                gBattleStatus.selectedMoveID = MOVE_RUN_AWAY;
                btl_set_state(BATTLE_STATE_RUN_AWAY);
                break;
            case BTL_MENU_TYPE_CHANGE_PARTNER:
                moveType = MOVE_TYPE_SWITCH;
                for (s32 i = 0; i < ARRAY_COUNT(gPlayerData.partners); i++) {
                    if (gPlayerData.partners[i].enabled && i != gPlayerData.curPartner) {
                        moveChoices[moveCount++] = i;
                    }
                }
                break;
            default:
                return;
        }
    }

    // pick a random target and move
    if (moveCount == 0) {
        battleQueueMario = FALSE;
        return;
    }
    s16 moveId = moveChoices[rand_int(moveCount - 1)];
    MoveData *move;
    switch (moveType) {
        case MOVE_TYPE_ITEMS:
            move = &gMoveTable[MOVE_ITEMS];
            break;
        case MOVE_TYPE_SWITCH:
            move = &gMoveTable[MOVE_SWITCH_PARTNER];
            break;
        default:
            move = &gMoveTable[moveId];
            break;
    }

    gBattleStatus.selectedMoveID = moveId;
    gBattleStatus.curTargetListFlags = move->flags;
    switch (move->category) {
        case MOVE_TYPE_JUMP:
            gBattleStatus.moveCategory = BTL_MENU_TYPE_JUMP;
            gBattleStatus.moveArgument = gPlayerData.bootsLevel;
            break;
        case MOVE_TYPE_HAMMER:
            gBattleStatus.moveCategory = BTL_MENU_TYPE_SMASH;
            gBattleStatus.moveArgument = gPlayerData.hammerLevel;
            break;
        case MOVE_TYPE_STAR_POWER:
            gBattleStatus.moveCategory = BTL_MENU_TYPE_STAR_POWERS;
            gBattleStatus.moveArgument = moveId - MOVE_FOCUS;
            break;
        case MOVE_TYPE_ITEMS:
            gBattleStatus.moveCategory = BTL_MENU_TYPE_ITEMS;
            gBattleStatus.moveArgument = moveId;
            gBattleStatus.selectedMoveID = MOVE_ITEMS;
            gBattleStatus.curTargetListFlags = gItemTable[moveId].targetFlags | TARGET_FLAG_PRIMARY_ONLY;
            gBattleStatus.curAttackElement = 0;
            break;
        case MOVE_TYPE_SWITCH:
            gBattleStatus.moveCategory = BTL_MENU_TYPE_CHANGE_PARTNER;
            gBattleStatus.selectedMoveID = MOVE_SWITCH_PARTNER;
            gBattleStatus.moveArgument = moveId;
            gBattleStatus.unk_1AC = moveId;
            break;
        default:
            return;
    }

    clear_windows();
    if (move->category == MOVE_TYPE_SWITCH) {
        btl_set_state(BATTLE_STATE_CHANGE_PARTNER);
    } else {
        Actor *player = gBattleStatus.playerActor;
        create_current_pos_target_list(player);
        player->selectedTargetIndex = rand_int(player->targetListLength - 1);
        btl_set_state(BATTLE_STATE_PLAYER_MOVE);
    }
    battleQueueMario = FALSE;
}

////////////////////////////////////////////////////////////////////////////////

static b8 isOverworld() {
    return !gGameStatus.isBattle;
}

static b8 canKnockback() {
    return !gGameStatus.isBattle && !chaosLevitating;
}

static b8 canTouchLava() {
    // only trigger when grounded
    return isOverworld() && gPlayerStatus.actionState <= ACTION_STATE_RUN;
}

static b8 isValidBattle() {
    if (!gGameStatus.isBattle || gPlayerData.curPartner == PARTNER_GOOMPA
        || gBattleStatus.flags1 & BS_FLAGS1_TUTORIAL_BATTLE || evt_get_variable(NULL, GB_StoryProgress) == STORY_INTRO)
    {
        return FALSE;
    }
    for (s32 i = 0; i < ARRAY_COUNT(gBattleStatus.enemyActors); i++) {
        if (gBattleStatus.enemyActors[i] != NULL) {
            return TRUE;
        }
    }
    return FALSE;
}

static s32 getTotalEquippedBpCost() {
    s32 totalCost = 0;
    for (s32 i = 0; i < ARRAY_COUNT(gPlayerData.equippedBadges); i++) {
        s16 itemID = gPlayerData.equippedBadges[i];
        if (itemID != ITEM_NONE) {
            s32 moveID = gItemTable[itemID].moveID;
            totalCost += gMoveTable[moveID].costBP;
        }
    }
    return totalCost;
}

static b8 canEquipBadge() {
    s32 availableBp = gPlayerData.maxBP - getTotalEquippedBpCost();
    if (availableBp == 0) {
        return FALSE;
    }
    for (s32 i = 0; i < 128; i++) {
        s16 badgeId = gPlayerData.badges[i];
        if (badgeId == 0) {
            continue;
        }
        if (item_is_badge(badgeId) && gMoveTable[gItemTable[badgeId].moveID].costBP <= availableBp &&
            !is_badge_equipped(badgeId)) {
            return TRUE;
        }
    }
    return FALSE;
}

static b8 canUnequipBadge() {
    for (s32 i = 0; i < 64; i++) {
        if (gPlayerData.equippedBadges[i] != 0) {
            return TRUE;
        }
    }
    return FALSE;
}

static b8 canPointSwap() {
    return gPlayerData.curHP != gPlayerData.curFP;
}

static b8 hasMushroom() {
    for (s32 i = 0; i < 10; i++) {
        for (s32 j = 0; j < ARRAY_COUNT(mushroomIds); j++) {
            if (gPlayerData.invItems[i] == mushroomIds[j]) {
                return TRUE;
            }
        }
    }
    return FALSE;
}

static b8 canRememberThis() {
    return chaosTimers[TIMER_REMEMBER_THIS] < 0;
}

////////////////////////////////////////////////////////////////////////////////

#if CHAOS_DEBUG
static void toggleRandomEffects(ChaosEffectData* effect) {
    if (randomEffects) {
        for (s32 i = 0; i < totalEffectCount; i++) {
            ChaosEffectData *nextEffect = &effectData[i];
            if (nextEffect->timer > 0 && nextEffect->off != NULL) {
                nextEffect->off(nextEffect);
            }
            nextEffect->timer = 0;
        }
    }
    randomEffects = !randomEffects;
}
#endif

static void posRewind(ChaosEffectData *effect) {
    if (rewindTime == TIMER_DISABLED) {
        rewindSaved = FALSE;
        rewindTime = effect->timer;
    }

    // prevent loading a position from a previous map
    if (get_game_mode() == GAME_MODE_CHANGE_MAP) {
        rewindSaved = FALSE;
        return;
    }

    if (effect->timer <= rewindTime) {
        if (rewindSaved) {
            gPlayerStatus.pos = rewindPos;
            rewindTime -= rand_int(60) + 1;
        } else {
            rewindPos = gPlayerStatus.pos;
            rewindTime -= rand_int(30) + 1;
        }
        rewindSaved = !rewindSaved;
    }
}

static void posRewindOff(ChaosEffectData *effect) {
    rewindTime = TIMER_DISABLED;
}

static void levitate(ChaosEffectData *effect) {
    if (!chaosLevitating) {
        chaosLevitating = TRUE;
    }

    gPlayerStatus.curSpeed = 0.0f;
    gPlayerStatus.flags |= PS_FLAG_JUMPING;
    gPlayerStatus.flags &= ~(PS_FLAG_FALLING);
    gPlayerStatus.timeInAir = 1;

    gPlayerStatus.pos.y += 0.2f;

    if (gGameStatus.peachFlags & (PEACH_FLAG_IS_PEACH)) {
        PlayerActionsTable[5].flag = TRUE;
    }
}

static void levitateOff(ChaosEffectData *effect) {
    chaosLevitating = FALSE;
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

static void actorChase(ChaosEffectData *effect) {
    for (s32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc != NULL) {
            magnetPosStep(&npc->pos);
        }
    }
    for (s32 i = 0; i < MAX_ENTITIES; i++) {
        Entity *entity = (*gCurrentEntityListPtr)[i];
        if (entity != NULL) {
            magnetPosStep(&entity->pos);
        }
    }
    for (s32 i = 0; i < MAX_ITEM_ENTITIES; i++) {
        ItemEntity *entity = (gCurrentItemEntities)[i];
        if (entity != NULL) {
            magnetPosStep(&entity->pos);
        }
    }
}

static void knockback(ChaosEffectData *effect) {
    if (knockbackTime == TIMER_DISABLED) {
        knockbackTime = effect->timer;
    }

    if (effect->timer == knockbackTime) {
        set_action_state(ACTION_STATE_KNOCKBACK);
        knockbackTime -= rand_int(90) + 30;
    }
}

static void knockbackOff(ChaosEffectData *effect) {
    knockbackTime = TIMER_DISABLED;
}

static void slowGo(ChaosEffectData *effect) {
    chaosSlowGo = !chaosSlowGo;
}

static void topDownCam(ChaosEffectData *effect) {
    chaosTopDownCam = !chaosTopDownCam;
}

static void intangibleEnemies(ChaosEffectData *effect) {
    gGameStatus.debugEnemyContact = !gGameStatus.debugEnemyContact;
}

static void spinAngle(ChaosEffectData *effect) {
    chaosSpinAngle = !chaosSpinAngle;
}

static void lava(ChaosEffectData *effect) {
    set_action_state(ACTION_STATE_HIT_LAVA);
}

static void rotateMario(ChaosEffectData *effect) {
    if (!chaosRotating) {
        chaosRotating = TRUE;
        marioPitch = gPlayerStatus.pitch;
        marioFlipYaw = gPlayerStatus.flipYaw[gCurrentCameraID];
        marioSpriteFacingAngle = gPlayerStatus.spriteFacingAngle;
        pitchSpeed = rand_float() * 6 + 4;
        yawSpeed = rand_float() * 6 + 4;
        if (rand_int(100) < 50) {
            pitchSpeed *= -1;
        }
        if (rand_int(100) < 50) {
            yawSpeed *= -1;
        }
    }
    marioPitch += pitchSpeed;
    marioFlipYaw += yawSpeed;
    marioSpriteFacingAngle += yawSpeed;
    if (marioFlipYaw >= 360) {
        marioFlipYaw -= 360;
    }
    if (marioSpriteFacingAngle >= 360) {
        marioSpriteFacingAngle -= 360;
    }
    if (marioPitch >= 360) {
        marioPitch -= 360;
    }
    gPlayerStatus.pitch = marioPitch;
    gPlayerStatus.spriteFacingAngle = marioSpriteFacingAngle;
    gPlayerStatus.flipYaw[gCurrentCameraID] = marioFlipYaw;
}

static void rotateMarioOff(ChaosEffectData *effect) {
    chaosRotating = FALSE;
}

static void negativeAttack(ChaosEffectData *effect) {
    chaosHealingTouch = !chaosHealingTouch;
}

static void randomEnemyHp(ChaosEffectData *effect) {
    for (s32 i = 0; i < ARRAY_COUNT(gBattleStatus.enemyActors); i++) {
        Actor *enemy = gBattleStatus.enemyActors[i];
        if (enemy == NULL || enemy->maxHP == 1) {
            continue;
        }
        s16 newHp = enemy->curHP;
        while (newHp == enemy->curHP) {
            newHp = rand_int(enemy->maxHP - 1) + 1;
        }
        enemyHpDeltas[i] = newHp - enemy->curHP;
        chaosTimers[TIMER_ENEMY_HP_UPDATE] = 34;
    }
}

EvtScript N(EVS_Shuffle_Sparkles) = {
    Call(PlaySound, SOUND_MULTIPLE_STAR_SPIRITS_APPEAR)
    Call(GetActorPos, ACTOR_PLAYER, LVar0, LVar1, LVar2)
    Add(LVar1, 15)
    PlayEffect(EFFECT_SPARKLES, 0, LVar0, LVar1, LVar2, 10)
    Call(ActorExists, ACTOR_PARTNER, LVar0)
    IfEq(LVar0, TRUE)
        Call(GetActorPos, ACTOR_PARTNER, LVar0, LVar1, LVar2)
        Add(LVar1, 15)
        PlayEffect(EFFECT_SPARKLES, 0, LVar0, LVar1, LVar2, 10)
    EndIf
    Set(LVar3, ACTOR_ENEMY0)
    Loop(MAX_ENEMY_ACTORS)
        Call(ActorExists, LVar3, LVar0)
        IfEq(LVar0, TRUE)
            Call(GetActorPos, LVar3, LVar0, LVar1, LVar2)
            Add(LVar1, 15)
            PlayEffect(EFFECT_SPARKLES, 0, LVar0, LVar1, LVar2, 10)
            Add(LVar3, 1)
        EndIf
    EndLoop
    Return
    End
};

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

static void shuffleBattlePos(ChaosEffectData *effect) {
    Actor *actors[26] = {0};
    b8 atHome[26] = {0};
    u8 actorIdx = 0;
    actors[actorIdx] = gBattleStatus.playerActor;
    atHome[actorIdx++] = actorAtHome(gBattleStatus.playerActor);
    if (gBattleStatus.partnerActor != NULL) {
        actors[actorIdx] = gBattleStatus.partnerActor;
        atHome[actorIdx++] = actorAtHome(gBattleStatus.partnerActor);
    }
    for (s32 i = 0; i < MAX_ENEMY_ACTORS; i++) {
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
    for (s32 i = 0; i < actorCount; i++) {
        oldPos[i] = actors[i]->homePos;
        oldHealth[i] = actors[i]->healthBarPos;
    }
    for (s32 i = 0; i < actorCount; i++) {
        u8 oldIdx = rand_int(actorIdx);
        newPos[i] = oldPos[oldIdx];
        newHealth[i] = oldHealth[oldIdx];
        oldPos[oldIdx] = oldPos[actorIdx];
        oldHealth[oldIdx] = oldHealth[actorIdx--];
    }

    // apply new position homes, move them if they're not away from their current home (aka probably attacking)
    for (s32 i = 0; i < actorCount; i++) {
        actors[i]->homePos.x = newPos[i].x;
        actors[i]->homePos.z = newPos[i].z;
        actors[i]->healthBarPos.x = newPos[i].x;
        actors[i]->healthBarPos.z = newPos[i].z;
        if (atHome[i]) {
            actors[i]->curPos.x = newPos[i].x;
            actors[i]->curPos.z = newPos[i].z;
        }
    }
    start_script(&N(EVS_Shuffle_Sparkles), EVT_PRIORITY_A, 0);
}

static void randomMarioMove(ChaosEffectData *effect) {
    battleQueueMario = TRUE;
}

static void equipBadge(ChaosEffectData *effect) {
    s32 availableBp = gPlayerData.maxBP - getTotalEquippedBpCost();
    s16 equippableBadges[128];
    u8 count = 0;
    for (s32 i = 0; i < 128; i++) {
        s16 badgeId = gPlayerData.badges[i];
        if (badgeId == 0) {
            continue;
        }
        s8 badgeCost = gMoveTable[gItemTable[badgeId].moveID].costBP;
        if (badgeCost > availableBp) {
            continue;
        }
        if (!is_badge_equipped(badgeId)) {
            equippableBadges[count++] = badgeId;
        }
    }

    s16 equipId = equippableBadges[rand_int(count - 1)];
    for (s32 i = 0; i < 64; i++) {
        if (gPlayerData.equippedBadges[i] == 0) {
            gPlayerData.equippedBadges[i] = equipId;
            sfx_play_sound(SOUND_MENU_BADGE_EQUIP);
            return;
        }
    }

}

static void unequipBadge(ChaosEffectData *effect) {
    s32 eqBadgeCount = 0;
    for (s32 i = 0; i < 64; i++) {
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

static void pointSwap(ChaosEffectData *effect) {
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
    chaosTimers[TIMER_HP_SOUND] = 20;
    chaosTimers[TIMER_FP_SOUND] = 20;
}

static void perilSound(ChaosEffectData *effect) {
    if (perilTime == TIMER_DISABLED) {
        perilTime = effect->timer;
    }

    if (effect->timer == perilTime) {
        sfx_play_sound(SOUND_PERIL);
        perilTime -= 15 + rand_int(25);
    }
}

static void perilSoundOff(ChaosEffectData *effect) {
    perilTime = TIMER_DISABLED;
}

static void squishActor(s8 id, ActorType actorType, Vec3f *scale) {
    b8 existingData = FALSE;
    ActorScaleData *scaleData = NULL;
    for (s32 i = 0; i < ACTOR_DATA_COUNT; i++) {
        ActorScaleData *scaleBuffer = &actorScaleBuffer[i];
        if (scaleBuffer->id == id && scaleBuffer->actorType == actorType) {
            existingData = TRUE;
            scaleData = scaleBuffer;
            break;
        } else if (scaleBuffer->id == -1){
            scaleData = scaleBuffer;
            break;
        }
    }
    if (existingData) {
        scaleData->curScale.x += 0.03f;
        scaleData->curScale.z += 0.03f;
        scaleData->curScale.y -= 0.0005f;
        scale->x = scaleData->curScale.x;
        scale->z = scaleData->curScale.z;
        scale->y = scaleData->curScale.y;
    } else if (scaleData != NULL) {
        scaleData->id = id;
        scaleData->actorType = actorType;
        scaleData->originalScale.x = scaleData->curScale.x = scale->x;
        scaleData->originalScale.z = scaleData->curScale.z = scale->z;
        scaleData->originalScale.y = scaleData->curScale.y = scale->y;
    }
}

static void squish(ChaosEffectData *effect) {
    for (s32 i = 0; i < MAX_NPCS; i++) {
        Npc *npc = (*gCurrentNpcListPtr)[i];
        if (npc == NULL) {
            continue;
        }
        squishActor(npc->npcID, ACTOR_NPC, &npc->scale);
    }
    for (s32 i = 0; i < MAX_ENEMY_ACTORS; i++) {
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

static void squishOff(ChaosEffectData *effect) {
    for (s32 i = 0; i < ACTOR_DATA_COUNT; i++) {
        ActorScaleData *scaleBuffer = &actorScaleBuffer[i];
        if (scaleBuffer->id == -1) {
            continue;
        }
        switch (scaleBuffer->actorType) {
            case ACTOR_NPC: {
                Npc *npc = get_npc_safe(scaleBuffer->id);
                if (npc != NULL) {
                    npc->scale.x = scaleBuffer->originalScale.x;
                    npc->scale.z = scaleBuffer->originalScale.z;
                    npc->scale.y = scaleBuffer->originalScale.y;
                }
                break;
            }
            case ACTOR_ENEMY: {
                Actor *enemy = gBattleStatus.enemyActors[scaleBuffer->id];
                if (enemy != NULL) {
                    enemy->scale.x = scaleBuffer->originalScale.x;
                    enemy->scale.z = scaleBuffer->originalScale.z;
                    enemy->scale.y = scaleBuffer->originalScale.y;
                }
                break;
            }
            case ACTOR_BATTLE_PARTNER: {
                gBattleStatus.partnerActor->scale.x = scaleBuffer->originalScale.x;
                gBattleStatus.partnerActor->scale.z = scaleBuffer->originalScale.z;
                gBattleStatus.partnerActor->scale.y = scaleBuffer->originalScale.y;
            }
        }
        scaleBuffer->id = -1;
    }
}

static void allSfxAttackFx(ChaosEffectData *effect) {
    chaosAllSfxAttackFx = !chaosAllSfxAttackFx;
}

static void hideModels(ChaosEffectData *effect) {
    chaosHideModels = !chaosHideModels;
}

static void randomHp(ChaosEffectData *effect) {
    s8 oldHp = gPlayerData.curHP;
    while (gPlayerData.curHP == oldHp) {
        gPlayerData.curHP = rand_int(gPlayerData.curMaxHP - 1) + 1;
    }
    chaosHpSoundPlayed = FALSE;
    chaosTimers[TIMER_HP_SOUND] = 20;
}

static void randomFp(ChaosEffectData *effect) {
    s8 oldFp = gPlayerData.curFP;
    while (gPlayerData.curFP == oldFp) {
        gPlayerData.curFP = rand_int(gPlayerData.curMaxFP);
    }
    chaosFpSoundPlayed = FALSE;
    chaosTimers[TIMER_FP_SOUND] = 20;
}

static void addRemoveCoins(ChaosEffectData *effect) {
    s32 coins = rand_int(99) + 1;
    if (rand_int(1)) {
        coins *= -1;
    }
    add_coins(coins);
    sfx_play_sound(SOUND_COIN_PICKUP);
    open_status_bar_quickly();
}

static void addRemoveStarPoints(ChaosEffectData *effect) {
    s32 sp = rand_int(24) + 1;
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

static void randomTattle(ChaosEffectData *effect) {
    start_script(&N(EVS_Random_Tattle), EVT_PRIORITY_A, 0);
}

static void badMusic(ChaosEffectData *effect) {
    if (chaosBadMusic == 0) {
        chaosTimers[TIMER_BAD_MUSIC] = 5 * 30;
        chaosBadMusic = 1;
    } else if (chaosTimers[TIMER_BAD_MUSIC] == 0) {
        chaosTimers[TIMER_BAD_MUSIC] = chaosBadMusic * 5 * 30;
        chaosBadMusic++;
    }
}

static void badMusicOff(ChaosEffectData *effect) {
    chaosBadMusic = 0;
}

static void expireMushroom(ChaosEffectData *effect) {
    s32 invIdx[10];
    u8 count = 0;
    for (s32 i = 0; i < 10; i++) {
        for (s32 j = 0; j < ARRAY_COUNT(mushroomIds); j++) {
            if (gPlayerData.invItems[i] == mushroomIds[j]) {
                invIdx[count++] = i;
                break;
            }
        }
    }

    if (count > 0) {
        s32 idx = invIdx[rand_int(count - 1)];
        gPlayerData.invItems[idx] = ITEM_DRIED_SHROOM;
        sfx_play_sound(SOUND_HIT_BONES); // best sound I can find so far, but could be better
    }
}

static void rotateCamera(ChaosEffectData *effect) {
    chaosRotateCamera = TRUE;
    guRotateF(chaosRotateMtx, (rand_float() * 270.0f) + 45.0f, 0.0f, 0.0f, -1.0f);
}

static void rotateCameraOff(ChaosEffectData *effect) {
    chaosRotateCamera = FALSE;
}

static void corruptBg(ChaosEffectData *effect) {
    if (chaosBackgroundChanged) {
        // save the uncorrupted background anytime the game changes it
        for (s32 i = 0; i < 256; i++) {
            bgSaved.palette[i] = gBackgroundImage.palette[i];
        }
        bgSaved.startX = gBackgroundImage.startX;
        bgSaved.startY = gBackgroundImage.startY;
        bgSaved.width = gBackgroundImage.width;
        bgSaved.height = gBackgroundImage.height;
        chaosBackgroundChanged = FALSE;
    }

    // corrupt one random byte of the background palette
    BackgroundHeader* bg = &gBackgroundImage;
    u8* pal = (u8*)bg->palette;
    u8 randPalByteOffset = rand_int(511);

    pal[randPalByteOffset] = rand_int(255);
}

static void corruptBgOff(ChaosEffectData *effect) {
    for (s32 i = 0; i < 256; i++) {
        gBackgroundImage.palette[i] = bgSaved.palette[i];
    }
    gBackgroundImage.startX = bgSaved.startX;
    gBackgroundImage.startY = bgSaved.startY;
    gBackgroundImage.width = bgSaved.width;
    gBackgroundImage.height = bgSaved.height;
}

static void reverseAnalog(ChaosEffectData *effect) {
    chaosReverseAnalog = !chaosReverseAnalog;
}

static void shuffleButtons(ChaosEffectData *effect) {
    chaosButtonMap[0] = BUTTON_C_RIGHT;
    chaosButtonMap[1] = BUTTON_C_LEFT;
    chaosButtonMap[2] = BUTTON_C_DOWN;
    chaosButtonMap[3] = BUTTON_C_UP;
    chaosButtonMap[4] = BUTTON_R;
    chaosButtonMap[5] = BUTTON_START;
    chaosButtonMap[6] = BUTTON_Z;
    chaosButtonMap[7] = BUTTON_B;
    chaosButtonMap[8] = BUTTON_A;
    for (s32 i = 0; i < ARRAY_COUNT(chaosButtonMap) - 1; i++) {
        s32 idx = rand_int(ARRAY_COUNT(chaosButtonMap) - i - 1) + i;
        enum Buttons temp = chaosButtonMap[i];
        chaosButtonMap[i] = chaosButtonMap[idx];
        chaosButtonMap[idx] = temp;
    }
    chaosShuffleButtons = TRUE;
}

static void shuffleButtonsOff(ChaosEffectData *effect) {
    chaosShuffleButtons = FALSE;
}

static void rememberThis(ChaosEffectData *effect) {
    // very hacky location but I'm running into issues creating a proper framebuffer - possibly shifting related?
    chaosSavedFrame = (u16*)((osMemSize | 0xA0000000) - FB_SIZE);
    memcpy(chaosSavedFrame, osViGetCurrentFramebuffer(), FB_SIZE);
    chaosTimers[TIMER_REMEMBER_THIS] = rand_int(30 * 60 * 5); // 5 minutes
    // TODO: edit text onto frame
}
