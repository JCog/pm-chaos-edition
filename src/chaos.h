#ifndef _PAPERMARIO_CHAOS_EDITION_CHAOS_H_
#define _PAPERMARIO_CHAOS_EDITION_CHAOS_H_

#include "common.h"
#include "dx/config.h"

#define NAMESPACE chaos

struct ChaosEffectData {
    const char *name;
    b8 everyFrame;
    s16 timer;
    s8 maxSeconds;
    void (*func)();
    void (*off)();
    b8 (*canTrigger)();
};

extern struct ChaosEffectData effectData[];
extern u8 totalEffectCount;
#if CHAOS_DEBUG
extern b8 randomEffects;
#endif

void handleTimers(void);

void chaosUpdate(void);

#endif
