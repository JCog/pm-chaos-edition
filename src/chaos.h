#ifndef _PAPERMARIO_CHAOS_EDITION_CHAOS_H_
#define _PAPERMARIO_CHAOS_EDITION_CHAOS_H_

#include "common.h"

#define CHAOS_DEBUG TRUE
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

void handleTimers(void);

void chaosUpdate(void);

#endif
