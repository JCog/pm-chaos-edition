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

extern ChaosEffectData effectData[];
extern const u8 totalEffectCount;
extern b8 randomEffects;

extern s16 chaosTimers[TIMER_MAX];
extern b8 chaosMenuOpen;
extern b8 chaosLevitating;
extern b8 chaosSlowGo;
extern b8 chaosTopDownCam;
extern b8 chaosHealingTouch;
extern b8 chaosAllSfxAttackFx;
extern b8 chaosHideModels;
extern b8 chaosSpinAngle;
extern f32 chaosPlayerPitch;
extern f32 chaosPlayerSpriteAngle;
extern s16 chaosPlayerPitchOffset;
extern b8 chaosHpSoundPlayed;
extern b8 chaosFpSoundPlayed;
extern b8 chaosRotateCamera;
extern b8 chaosZoomedOut;
extern Matrix4f chaosZoomedOutMtx;
extern b8 chaosBackgroundChanged;
extern Matrix4f chaosRotateMtx;
extern s8 chaosBadMusic;
extern b8 chaosReverseAnalog;
extern b8 chaosShuffleButtons;
extern enum Buttons chaosButtonMap[9];
extern b8 chaosRandomButton;
extern b8 chaosRememberThis;

void handleTimers(void);
void handleBattleQueue(void);

void chaosUpdate(void);

#endif
