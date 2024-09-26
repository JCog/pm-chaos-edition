#ifndef _PAPERMARIO_CHAOS_EDITION_CHAOS_H_
#define _PAPERMARIO_CHAOS_EDITION_CHAOS_H_

#include "common.h"

#define NAMESPACE chaos

typedef enum ChaosTimer {
    TIMER_ENEMY_HP_UPDATE,
    TIMER_HP_SOUND,
    TIMER_FP_SOUND,
    TIMER_BAD_MUSIC,
    TIMER_REMEMBER_THIS,
    TIMER_MAX
} ChaosTimer;

typedef struct ChaosEffectData {
    const char *name;
    b8 everyFrame;
    s16 timer;
    s8 maxSeconds;
    void (*func)(struct ChaosEffectData*);
    void (*off)(struct ChaosEffectData*);
    b8 (*canTrigger)();
} ChaosEffectData;

typedef struct ChaosStatus {
    s16 timers[TIMER_MAX];
    b8 menuOpen;
    b8 levitating;
    b8 slowGo;
    b8 topDownCam;
    b8 healingTouch;
    Vec3f squishScale;
    b8 allSfxAttackFx;
    b8 hideModels;
    b8 spinAngle;
    b8 turbo;
    f32 playerPitch;
    f32 playerSpriteAngle;
    s16 playerPitchOffset;
    b8 hpSoundPlayed;
    b8 fpSoundPlayed;
    b8 rotateCamera;
    b8 zoomedOut;
    Matrix4f rotateMtx;
    Matrix4f zoomedOutMtx;
    b8 backgroundChanged;
    s8 badMusic;
    b8 reverseAnalog;
    b8 shuffleButtons;
    enum Buttons buttonMap[9];
    b8 randomButton;
    b8 rememberThis;
    b8 cantJump;
    b8 cantHammer;
    b8 randomACs;
} ChaosStatus;

extern ChaosStatus chaosStatus;

extern ChaosEffectData effectData[];
extern const u8 totalEffectCount;
extern b8 randomEffects;


void handleTimers(void);
void handleBattleQueue(void);

void initChaosStatus(void);
void chaosUpdate(void);

#endif
