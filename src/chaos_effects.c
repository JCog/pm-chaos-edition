#include "chaos.h"
#include "effects.h"
#include "inventory.h"
#include "script_api/battle.h"
#include "world/actions.h"

#define ACTOR_DATA_COUNT 64

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
static b8 canTouchLava(void);
static b8 isValidBattle(void);
static b8 canEquipBadge(void);
static b8 canUnequipBadge(void);
static b8 canPointSwap(void);
static b8 hasMushroom(void);

#if CHAOS_DEBUG
static void toggleRandomEffects(void);
#endif
// overworld
static void posLoad(void);
static void levitate(void);
static void levitateStop(void);
static void actorMagnet(void);
static void knockback(void);
static void slowGo(void);
static void topDownCam(void);
static void intangibleEnemies(void);
static void spinAngle(void);
static void lava(void);
static void rotateMario(void);
static void rotateMarioOff(void);
// battle
static void negativeAttack(void);
static void randomEnemyHp(void);
static void shuffleBattlePos(void);
static void randomMarioMove(void);
// anywhere
static void equipBadge(void);
static void unequipBadge(void);
static void perilSound(void);
static void squish(void);
static void squishOff(void);
static void allSfxAttackFx(void);
static void hideModels(void);
static void pointSwap(void);
static void randomHp(void);
static void randomFp(void);
static void addRemoveCoins(void);
static void addRemoveStarPoints(void);
static void randomTattle(void);
static void badMusic(void);
static void badMusicOff(void);
static void expireMushroom(void);
static void rotateCamera(void);
static void rotateCameraOff(void);
static void corruptBg(void);
static void corruptBgOff(void);
static void reverseAnalog(void);
static void shuffleButtons(void);
static void shuffleButtonsOff(void);

ChaosEffectData effectData[] = {
    #if CHAOS_DEBUG
    {"Toggle Random Effects",   FALSE,  0,  0,  toggleRandomEffects,    NULL,               NULL},
    #endif
    // overworld
    {"Rewind",                  TRUE,   0,  60, posLoad,                NULL,               isOverworld},
    {"Levitate",                TRUE,   0,  10, levitate,               levitateStop,       isOverworld},
    {"Actor Chase",             TRUE,   0,  30, actorMagnet,            NULL,               isOverworld},
    {"Knockback",               TRUE,   0,  60, knockback,              NULL,               isOverworld},
    {"Slow Go",                 FALSE,  0,  60, slowGo,                 slowGo,             isOverworld},
    {"Top-Down Cam",            FALSE,  0,  60, topDownCam,             topDownCam,         isOverworld},
    {"Intangible Enemies",      FALSE,  0,  60, intangibleEnemies,      intangibleEnemies,  isOverworld},
    {"Random Spin Angle",       FALSE,  0,  60, spinAngle,              spinAngle,          isOverworld},
    {"Lava",                    FALSE,  0,  0,  lava,                   NULL,               canTouchLava},
    {"Rotate Mario",            TRUE,   0,  60, rotateMario,            rotateMarioOff,     isOverworld},
    // battle
    {"Healing Touch",           FALSE,  0,  60, negativeAttack,         negativeAttack,     isValidBattle},
    {"Random Enemy HP",         FALSE,  0,  0,  randomEnemyHp,          NULL,               isValidBattle},
    {"Location Shuffle",        FALSE,  0,  0,  shuffleBattlePos,       NULL,               isValidBattle},
    {"Random Mario Move",       FALSE,  0,  0,  randomMarioMove,        NULL,               isValidBattle},
    // anywhere
    {"Equip Badge",             FALSE,  0,  0,  equipBadge,             NULL,               canEquipBadge},
    {"Unequip Badge",           FALSE,  0,  0,  unequipBadge,           NULL,               canUnequipBadge},
    {"Peril Sound",             TRUE,   0,  60, perilSound,             NULL,               NULL},
    {"Squish",                  TRUE,   0,  60, squish,                 squishOff,          NULL},
    {"All SFX AttackFX",        FALSE,  0,  60, allSfxAttackFx,         allSfxAttackFx,     NULL},
    {"Hide Models",             FALSE,  0,  60, hideModels,             hideModels,         NULL},
    {"Point Swap",              FALSE,  0,  0,  pointSwap,              NULL,               canPointSwap},
    {"Random HP",               FALSE,  0,  0,  randomHp,               NULL,               NULL},
    {"Random FP",               FALSE,  0,  0,  randomFp,               NULL,               NULL},
    {"Add/Remove Coins",        FALSE,  0,  0,  addRemoveCoins,         NULL,               NULL},
    {"Add/Remove Star Points",  FALSE,  0,  0,  addRemoveStarPoints,    NULL,               NULL},
    {"Random Tattle",           FALSE,  0,  0,  randomTattle,           NULL,               NULL},
    {"Bad Music",               TRUE,   0,  60, badMusic,               badMusicOff,        NULL},
    {"Mushroom Expires",        FALSE,  0,  0,  expireMushroom,         NULL,               hasMushroom},
    {"Rotate Camera",           FALSE,  0,  60, rotateCamera,           rotateCameraOff,    NULL},
    {"Corrupt Background",      TRUE,   0,  60, corruptBg,              corruptBgOff,       NULL},
    {"Reverse Analog Stick",    FALSE,  0,  60, reverseAnalog,          reverseAnalog,      NULL},
    {"Shuffle Buttons",         FALSE,  0,  60, shuffleButtons,         shuffleButtonsOff,  NULL},
};

const u8 totalEffectCount = ARRAY_COUNT(effectData);
b8 randomEffects = !CHAOS_DEBUG;

u32 frameCount = 0;
s16 chaosEnemyHpUpdateTimer = 0;
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

static b8 battleQueueMario = FALSE;
static f32 prevHeight = -10000.0f;
static s16 hpSoundTimer = 0;
static s16 fpSoundTimer = 0;
static s16 perilTimer = 0;
static s16 badMusicTimer = 0;
static s16 enemyHpDeltas[ARRAY_COUNT(gBattleStatus.enemyActors)];
static ActorScaleData actorScaleBuffer[] = {[0 ... ACTOR_DATA_COUNT] = {-1, 0, {0, 0, 0}} };
static u16 savedPalette[256];
static BackgroundHeader bgSaved = {.palette = &savedPalette[0]};
static f32 marioFlipYaw = 0.0f;
static f32 marioPitch = 0.0f;
static f32 marioSpriteFacingAngle = 0.0f;
static f32 yawSpeed;
static f32 pitchSpeed;

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
        chaosEnemyHpUpdateTimer += 4;
    }
}

static void decTimer(s16 *timer) {
    if (*timer >= 0) {
        (*timer)--;
    }
}

void handleTimers() {
    frameCount = gPlayerData.frameCounter / 2;
    decTimer(&chaosEnemyHpUpdateTimer);
    decTimer(&hpSoundTimer);
    decTimer(&fpSoundTimer);
    decTimer(&perilTimer);
    decTimer(&badMusicTimer);
    if (chaosEnemyHpUpdateTimer == 30) {
        updateEnemyHpDeltas();
    }
    if (hpSoundTimer == 0 && !chaosHpSoundPlayed) {
        sfx_play_sound(SOUND_HEART_PICKUP);
    }
    if (fpSoundTimer == 0 && !chaosFpSoundPlayed) {
        sfx_play_sound(SOUND_FLOWER_PICKUP);
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

static b8 isOverworld() {
    return !gGameStatus.isBattle;
}

static b8 canTouchLava() {
    // only trigger when grounded
    return isOverworld() && gPlayerStatus.actionState <= ACTION_STATE_RUN;
}

static b8 isValidBattle() {
    if (!gGameStatus.isBattle || gPlayerData.curPartner == PARTNER_GOOMPA || gBattleStatus.flags1 & BS_FLAGS1_TUTORIAL_BATTLE) {
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

////////////////////////////////////////////////////////////////////////////////

#if CHAOS_DEBUG
static void toggleRandomEffects() {
    if (randomEffects) {
        for (s32 i = 0; i < totalEffectCount; i++) {
            ChaosEffectData *effect = &effectData[i];
            if (effect->timer > 0 && effect->off != NULL) {
                effect->off();
            }
            effect->timer = 0;
        }
    }
    randomEffects = !randomEffects;
}
#endif

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

static void knockback() {
    if (frameCount % 60 == 0) {
        set_action_state(ACTION_STATE_KNOCKBACK);
    }
}

static void slowGo() {
    chaosSlowGo = !chaosSlowGo;
}

static void topDownCam() {
    chaosTopDownCam = !chaosTopDownCam;
}

static void intangibleEnemies() {
    gGameStatus.debugEnemyContact = !gGameStatus.debugEnemyContact;
}

static void spinAngle() {
    chaosSpinAngle = !chaosSpinAngle;
}

static void lava() {
    set_action_state(ACTION_STATE_HIT_LAVA);
}

static void rotateMario() {
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

static void rotateMarioOff() {
    chaosRotating = FALSE;
}

static void negativeAttack() {
    chaosHealingTouch = !chaosHealingTouch;
}

static void randomEnemyHp() {
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
        chaosEnemyHpUpdateTimer = 34;
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

static void shuffleBattlePos() {
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

static void randomMarioMove(void) {
    battleQueueMario = TRUE;
}

static void equipBadge() {
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

static void unequipBadge() {
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

static void perilSound() {
    if (perilTimer <= 0) {
        sfx_play_sound(SOUND_PERIL);
        perilTimer = 15 + rand_int(25);
    }
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

static void squish() {
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

static void squishOff() {
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

static void allSfxAttackFx() {
    chaosAllSfxAttackFx = !chaosAllSfxAttackFx;
}

static void hideModels() {
    chaosHideModels = !chaosHideModels;
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

static void randomTattle() {
    start_script(&N(EVS_Random_Tattle), EVT_PRIORITY_A, 0);
}

static void badMusic() {
    if (chaosBadMusic == 0) {
        badMusicTimer = 5 * 30;
        chaosBadMusic = 1;
    } else if (badMusicTimer == 0) {
        badMusicTimer = chaosBadMusic * 5 * 30;
        chaosBadMusic++;
    }
}

static void badMusicOff() {
    chaosBadMusic = 0;
}

static void expireMushroom() {
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

static void rotateCamera() {
    chaosRotateCamera = TRUE;
    guRotateF(chaosRotateMtx, (rand_float() * 270.0f) + 45.0f, 0.0f, 0.0f, -1.0f);
}

static void rotateCameraOff() {
    chaosRotateCamera = FALSE;
}

static void corruptBg() {
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

static void corruptBgOff() {
    for (s32 i = 0; i < 256; i++) {
        gBackgroundImage.palette[i] = bgSaved.palette[i];
    }
    gBackgroundImage.startX = bgSaved.startX;
    gBackgroundImage.startY = bgSaved.startY;
    gBackgroundImage.width = bgSaved.width;
    gBackgroundImage.height = bgSaved.height;
}

static void reverseAnalog() {
    chaosReverseAnalog = !chaosReverseAnalog;
}

static void shuffleButtons(void) {
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

static void shuffleButtonsOff() {
    chaosShuffleButtons = FALSE;
}
