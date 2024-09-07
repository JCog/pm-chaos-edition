#include "chaos.h"
#include "effects.h"
#include "script_api/battle.h"
#include "world/actions.h"

#define ACTOR_DATA_COUNT 64

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

// conditionals
static b8 isOverworld(void);
static b8 isBattle(void);
static b8 canUnequipBadge(void);
static b8 canPointSwap(void);

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
// battle
static void negativeAttack(void);
static void shuffleBattlePos(void);
// anywhere
static void unequipBadge(void);
static void pointSwap(void);
static void perilSound(void);
static void squish(void);
static void squishOff(void);
static void allSfxAttackFx(void);
static void hideModels(void);
static void randomHp(void);
static void randomFp(void);
static void addRemoveCoins(void);
static void addRemoveStarPoints(void);
static void randomTattle(void);
static void badMusic(void);
static void badMusicOff(void);

struct ChaosEffectData effectData[] = {
    {"Rewind",                  TRUE,   0,  60, posLoad,                NULL,               isOverworld},
    {"Levitate",                TRUE,   0,  10, levitate,               levitateStop,       isOverworld},
    {"Actor Chase",             TRUE,   0,  30, actorMagnet,            NULL,               isOverworld},
    {"Knockback",               TRUE,   0,  60, knockback,              NULL,               isOverworld},
    {"Slow Go",                 FALSE,  0,  60, slowGo,                 slowGo,             isOverworld},
    {"Top-Down Cam",            FALSE,  0,  60, topDownCam,             topDownCam,         isOverworld},
    {"Intangible Enemies",      FALSE,  0,  60, intangibleEnemies,      intangibleEnemies,  isOverworld},
    {"Random Spin Angle",       FALSE,  0,  60, spinAngle,              spinAngle,          isOverworld},
    {"Lava",                    FALSE,  0,  0,  lava,                   NULL,               isOverworld},
    {"Healing Touch",           FALSE,  0,  60, negativeAttack,         negativeAttack,     isBattle},
    {"Location Shuffle",        FALSE,  0,  0,  shuffleBattlePos,       NULL,               isBattle},
    {"Unequip Badge",           FALSE,  0,  0,  unequipBadge,           NULL,               canUnequipBadge},
    {"Point Swap",              FALSE,  0,  0,  pointSwap,              NULL,               canPointSwap},
    {"Peril Sound",             TRUE,   0,  60, perilSound,             NULL,               NULL},
    {"Squish",                  TRUE,   0,  60, squish,                 squishOff,          NULL},
    {"All SFX AttackFX",        FALSE,  0,  60, allSfxAttackFx,         allSfxAttackFx,     NULL},
    {"Hide Models",             FALSE,  0,  60, hideModels,             hideModels,         NULL},
    {"Random HP",               FALSE,  0,  0,  randomHp,               NULL,               NULL},
    {"Random FP",               FALSE,  0,  0,  randomFp,               NULL,               NULL},
    {"Add/Remove Coins",        FALSE,  0,  0,  addRemoveCoins,         NULL,               NULL},
    {"Add/Remove Star Points",  FALSE,  0,  0,  addRemoveStarPoints,    NULL,               NULL},
    {"Random Tattle",           FALSE,  0,  0,  randomTattle,           NULL,               NULL},
    {"Bad Music",               TRUE,   0,  60, badMusic,               badMusicOff,        NULL},
};

u8 totalEffectCount = ARRAY_COUNT(effectData);

u32 frameCount = 0;
static f32 prevHeight = -10000.0f;
static s16 hpSoundTimer = 0;
static s16 fpSoundTimer = 0;
static s16 perilTimer = 0;
static s16 badMusicTimer = 0;
static struct ActorScaleData actorScaleBuffer[] = {[0 ... ACTOR_DATA_COUNT] = {-1, 0, {0, 0, 0}} };

static void decTimer(s16 *timer) {
    if (*timer >= 0) {
        (*timer)--;
    }
}

void handleTimers() {
    frameCount = gPlayerData.frameCounter / 2;
    decTimer(&hpSoundTimer);
    decTimer(&fpSoundTimer);
    decTimer(&perilTimer);
    decTimer(&badMusicTimer);
    if (hpSoundTimer == 0 && !chaosHpSoundPlayed) {
        sfx_play_sound(SOUND_HEART_PICKUP);
    }
    if (fpSoundTimer == 0 && !chaosFpSoundPlayed) {
        sfx_play_sound(SOUND_FLOWER_PICKUP);
    }
}

static b8 isOverworld() {
    return !gGameStatus.isBattle;
}

static b8 isBattle() {
    return gGameStatus.isBattle;
}

static b8 canUnequipBadge() {
    for (u32 i = 0; i < 64; i++) {
        if (gPlayerData.equippedBadges[i] != 0) {
            return TRUE;
        }
    }
    return FALSE;
}

static b8 canPointSwap() {
    return gPlayerData.curHP != gPlayerData.curFP;
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

static void negativeAttack() {
    chaosHealingTouch = !chaosHealingTouch;
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