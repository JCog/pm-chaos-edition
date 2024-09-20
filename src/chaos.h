#ifndef _PAPERMARIO_CHAOS_EDITION_CHAOS_H_
#define _PAPERMARIO_CHAOS_EDITION_CHAOS_H_

#include "common.h"

#define NAMESPACE chaos

typedef struct ChaosEffectData {
    const char *name;
    b8 everyFrame;
    s16 timer;
    s8 maxSeconds;
    void (*func)();
    void (*off)();
    b8 (*canTrigger)();
} ChaosEffectData;

extern ChaosEffectData effectData[];
extern const u8 totalEffectCount;
extern b8 randomEffects;

void handleTimers(void);
void handleBattleQueue(void);

void chaosUpdate(void);

#endif
