#include "common.h"
#include "nu/nusys.h"
#include "chaos.h"

OSContPad D_8009A5B8;
BSS s16 D_8009A6A0;
BSS s16 D_8009A6A2;
BSS s16 D_8009A6A4;
BSS s16 D_8009A6A6;

const enum Buttons primaryButtons[] = {
    BUTTON_C_RIGHT, BUTTON_C_LEFT, BUTTON_C_DOWN, BUTTON_C_UP, BUTTON_R, BUTTON_START, BUTTON_Z, BUTTON_B, BUTTON_A
};

void func_800287F0(void) {
    gGameStatusPtr->curButtons[0] = 0;
    gGameStatusPtr->pressedButtons[0] = 0;
    gGameStatusPtr->heldButtons[0] = 0;
    gGameStatusPtr->stickX[0] = 0;
    gGameStatusPtr->stickY[0] = 0;
    gGameStatusPtr->prevButtons[0] = 0;
    gGameStatusPtr->unk_50[0] = 4;
    gGameStatusPtr->unk_48[0] = 15;
    gGameStatusPtr->unk_60 = 0;
    gGameStatusPtr->unk_58 = 0;
}

void func_80028838(void) {
    func_800287F0();
    D_8009A6A0 = 0;
    D_8009A6A2 = 0;
    D_8009A6A4 = 0;
    D_8009A6A6 = 0;
}

void update_input(void) {
    OSContPad* contData = &D_8009A5B8;
    s16 handleInput = FALSE;
    s16 cond1;
    s32 buttons;
    s16 stickX;
    s16 stickY;

    if (gGameStatusPtr->contBitPattern & 1) {
        handleInput = TRUE;
        nuContDataGet(contData, 0);
    }

    if (gGameStatusPtr->demoState != DEMO_STATE_NONE) {
        if (gGameStatusPtr->demoState < DEMO_STATE_CHANGE_MAP
            && (contData->button & (BUTTON_A | BUTTON_B | BUTTON_Z | BUTTON_START))
            && handleInput
        ) {
            gGameStatusPtr->demoState = DEMO_STATE_CHANGE_MAP;
        }
        contData->button = gGameStatusPtr->demoButtonInput;
        contData->stick_x = gGameStatusPtr->demoStickX;
        contData->stick_y = gGameStatusPtr->demoStickY;
        handleInput = TRUE;
    }

    if (!handleInput) {
        return;
    }

    stickX = contData->stick_x;
    stickY = contData->stick_y;
    if (stickX > 0) {
        stickX -= 4;
        if (stickX < 0) {
            stickX = 0;
        }
    }
    if (stickX < 0) {
        stickX += 4;
        if (stickX > 0) {
            stickX = 0;
        }
    }

    if (stickY > 0) {
        stickY -= 4;
        if (stickY < 0) {
            stickY = 0;
        }
    }
    if (stickY < 0) {
        stickY += 4;
        if (stickY > 0) {
            stickY = 0;
        }
    }
    if (chaosStatus.reverseAnalog) {
        stickX *= -1;
        stickY *= -1;
    }

    gGameStatusPtr->stickX[0] = stickX;
    gGameStatusPtr->stickY[0] = stickY;

    buttons = contData->button;
    if (chaosStatus.randomButton) {
        s32 idx = rand_int(ARRAY_COUNT(primaryButtons) - 1);
        for (s32 i = 0; i < ARRAY_COUNT(primaryButtons); i++) {
            if (!(buttons & primaryButtons[idx])) {
                buttons |= primaryButtons[idx];
                break;
            }
            idx++;
            idx %= ARRAY_COUNT(primaryButtons);
        }
        chaosStatus.randomButton = FALSE;
    }
    if (chaosStatus.shuffleButtons) {
        // keep d-pad, L, and stick values, but shuffle everything else
        s32 shuffled = buttons
            & ~(BUTTON_C_RIGHT | BUTTON_C_LEFT | BUTTON_C_DOWN | BUTTON_C_UP | BUTTON_R | BUTTON_START | BUTTON_Z
                | BUTTON_B | BUTTON_A);
        for (s32 i = 0; i < ARRAY_COUNT(primaryButtons); i++) {
            if (buttons & primaryButtons[i]) {
                shuffled |= chaosStatus.buttonMap[i];
            }
        }
        buttons = shuffled;
    }

    cond1 = FALSE;
    if (stickX > 0x20) {
        cond1 = TRUE;
        buttons |= BUTTON_STICK_RIGHT;
        if (!(gGameStatusPtr->prevButtons[0] & BUTTON_STICK_RIGHT)) {
            D_8009A6A0 = stickX;
        } else if (D_8009A6A4 == 0) {
            if (D_8009A6A0 < stickX) {
                D_8009A6A0 = stickX;
            }
        } else {
            if (D_8009A6A0 > stickX) {
                D_8009A6A0 = stickX;
            }
        }
    }

    if (stickX < -0x20) {
        cond1 = TRUE;
        buttons |= BUTTON_STICK_LEFT;
        if (!(gGameStatusPtr->prevButtons[0] & BUTTON_STICK_LEFT)) {
            D_8009A6A0 = stickX;
        } else if (D_8009A6A4 == 0) {
            if (D_8009A6A0 > stickX) {
                D_8009A6A0 = stickX;
            }
        } else {
            if (D_8009A6A0 < stickX)
            {
                D_8009A6A0 = stickX;
            }
        }
    }

    if (!cond1) {
        D_8009A6A4 = 0;
        D_8009A6A0 = stickX;
    }

    cond1 = FALSE;
    if (stickY > 0x20) {
        cond1 = TRUE;
        buttons |= BUTTON_STICK_UP;
        if (!(gGameStatusPtr->prevButtons[0] & BUTTON_STICK_UP)) {
            D_8009A6A2 = stickY;
        } else if (D_8009A6A6 == 0) {
            if (D_8009A6A2 < stickY) {
                D_8009A6A2 = stickY;
            }
        } else {
            if (D_8009A6A2 > stickY) {
                D_8009A6A2 = stickY;
            }
        }
    }

    if (stickY < -0x20) {
        cond1 = TRUE;
        buttons |= BUTTON_STICK_DOWN;
        if (!(gGameStatusPtr->prevButtons[0] & BUTTON_STICK_DOWN)) {
            D_8009A6A2 = stickY;
        } else if (D_8009A6A6 == 0) {
            if (D_8009A6A2 > stickY) {
                D_8009A6A2 = stickY;
            }
        } else {
            if (D_8009A6A2 < stickY) {
                D_8009A6A2 = stickY;
            }
        }
    }

    if (!cond1) {
        D_8009A6A6 = 0;
        D_8009A6A2 = stickY;
    }

    if (stickX > 0x20) {
        if (D_8009A6A4 == 1 && stickX - D_8009A6A0 > 0x10) {
            buttons &= ~BUTTON_STICK_RIGHT;
            D_8009A6A4 = 0;
        }
        if (D_8009A6A0 - stickX > 0x10) {
            D_8009A6A4 = 1;
        }
    }

    if (stickX < -0x20) {
        if (D_8009A6A4 == 1 && D_8009A6A0 - stickX > 0x10) {
            buttons &= ~BUTTON_STICK_LEFT;
            D_8009A6A4 = 0;
        }
        if (stickX - D_8009A6A0 > 0x10) {
            D_8009A6A4 = 1;
        }
    }

    if (stickY > 0x20) {
        if (D_8009A6A6 == 1 && stickY - D_8009A6A2 > 0x10) {
            buttons &= ~BUTTON_STICK_UP;
            D_8009A6A6 = 0;
        }
        if (D_8009A6A2 - stickY > 0x10) {
            D_8009A6A6 = 1;
        }
    }

    if (stickY < -0x20) {
        if (D_8009A6A6 == 1 && D_8009A6A2 - stickY > 0x10) {
            buttons &= ~BUTTON_STICK_DOWN;
            D_8009A6A6 = 0;
        }
        if (stickY - D_8009A6A2 > 0x10) {
            D_8009A6A6 = 1;
        }
    }

    gGameStatusPtr->curButtons[0] = buttons;
    gGameStatusPtr->pressedButtons[0] = gGameStatusPtr->curButtons[0] ^ gGameStatusPtr->prevButtons[0];
    gGameStatusPtr->pressedButtons[0] &= gGameStatusPtr->curButtons[0];

    if (gGameStatusPtr->curButtons[0] == 0) {
        gGameStatusPtr->heldButtons[0] = 0;
    } else if (gGameStatusPtr->prevButtons[0] != gGameStatusPtr->curButtons[0]) {
        gGameStatusPtr->heldButtons[0] = gGameStatusPtr->curButtons[0];
        gGameStatusPtr->unk_60 = -1;
        gGameStatusPtr->heldButtons[0] = gGameStatusPtr->curButtons[0] ^ gGameStatusPtr->prevButtons[0];
        gGameStatusPtr->heldButtons[0] &= gGameStatusPtr->curButtons[0];
        gGameStatusPtr->unk_58 = gGameStatusPtr->unk_48[0];
    } else {
        if (gGameStatusPtr->unk_60 >= 0) {
            gGameStatusPtr->unk_60--;
            if (gGameStatusPtr->unk_60 != 0) {
                gGameStatusPtr->heldButtons[0] = 0;
            } else {
                gGameStatusPtr->heldButtons[0] = gGameStatusPtr->curButtons[0];
                gGameStatusPtr->unk_60 = gGameStatusPtr->unk_50[0];
            }
        } else {
            gGameStatusPtr->unk_58--;
            if (gGameStatusPtr->unk_58 != 0) {
                gGameStatusPtr->heldButtons[0] = 0;
            } else {
                gGameStatusPtr->heldButtons[0] = gGameStatusPtr->curButtons[0];
                gGameStatusPtr->unk_60 = gGameStatusPtr->unk_50[0];
            }
        }
    }

    gGameStatusPtr->prevButtons[0] = gGameStatusPtr->curButtons[0];
}
