#include "common.h"
#include "script_api/battle.h"
#include "battle/action_cmd/hammer.h"
#include "sprite/player.h"

#include "world/common/todo/IsBerserkerEquipped.inc.c"
#include "world/common/todo/ShouldMovesAutoSucceed.inc.c"

EvtScript N(EVS_HammerSupport_SmashApproach) = {
    Call(InitTargetIterator)
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    Call(GetGoalPos, ACTOR_SELF, LVar0, LVar1, LVar2)
    Sub(LVar0, 32)
    Call(SetGoalPos, ACTOR_SELF, LVar0, LVar1, LVar2)
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_ATTACK_APPROACH)
    Call(SetActorSpeed, ACTOR_PLAYER, Float(5.0))
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Run)
    Call(PlayerRunToGoal, 0)
    Return
    End
};

EvtScript N(EVS_HammerSupport_QuakeApproach) = {
    Call(SetGoalPos, ACTOR_PLAYER, -33, 0, 0)
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_ATTACK_APPROACH)
    Call(SetActorSpeed, ACTOR_PLAYER, Float(5.0))
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Run)
    Call(PlayerRunToGoal, 0)
    Return
    End
};

// delay while player holds hammer on the ground before raising it
// can be sped up by pre-emptively holding left
EvtScript N(EVS_HammerSupport_BasicRaiseDelay) = {
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    Set(LVar1, 0)
    Loop(10)
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, TRUE)
            Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
            BreakLoop
        EndIf
        Wait(1)
        Add(LVar1, 1)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Begin)
    EndLoop
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Begin)
    Switch(LVar1)
        CaseLt(3)
            Wait(4)
        CaseLt(5)
            Wait(3)
        CaseLt(7)
            Wait(2)
        CaseLt(9)
            Wait(1)
        CaseLt(11)
            Wait(0)
    EndSwitch
    Return
    End
};

// delay while player holds hammer on the ground before raising it
// can be sped up by pre-emptively holding left
EvtScript N(EVS_HammerSupport_SuperRaiseDelay) = {
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    Set(LVar1, 0)
    Loop(10)
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, TRUE)
            Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
            BreakLoop
        EndIf
        Wait(1)
        Add(LVar1, 1)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Begin)
    EndLoop
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Begin)
    Switch(LVar1)
        CaseLt(3)
            Wait(4)
        CaseLt(5)
            Wait(3)
        CaseLt(7)
            Wait(2)
        CaseLt(9)
            Wait(1)
        CaseLt(11)
            Wait(0)
    EndSwitch
    Return
    End
};

// delay while player holds hammer on the ground before raising it
// can be sped up by pre-emptively holding left
EvtScript N(EVS_HammerSupport_UltraRaiseDelay) = {
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    Set(LVar1, 0)
    Loop(10)
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, TRUE)
            Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
            BreakLoop
        EndIf
        Wait(1)
        Add(LVar1, 1)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Begin)
    EndLoop
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Begin)
    Switch(LVar1)
        CaseLt(3)
            Wait(4)
        CaseLt(5)
            Wait(3)
        CaseLt(7)
            Wait(2)
        CaseLt(9)
            Wait(1)
        CaseLt(11)
            Wait(0)
    EndSwitch
    Return
    End
};

EvtScript N(EVS_HammerSupport_F) = {
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_AIM_HAMMER)
    Call(SetBattleCamOffsetY, 8)
    Call(InitTargetIterator)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_WINDUP)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_PullBack)
    Wait(4)
    Call(action_command_hammer_start, 0, 36, 3)
    Call(SetActionQuality, 0)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold1)
    Set(LVar1, 0)
    Loop(30)
        Wait(1)
        Call(GetActionQuality, LVar0)
        IfNe(LVar0, 0)
            IfNe(LVar1, 1)
                Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold2)
                Set(LVar1, 1)
            EndIf
        EndIf
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, FALSE)
            BreakLoop
        EndIf
    EndLoop
    Label(0)
        Wait(1)
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, TRUE)
            Goto(0)
        EndIf
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_PreSwing)
    Wait(3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Swing)
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_HAMMER_STRIKE)
    Return
    End
};

EvtScript N(EVS_HammerSupport_ReturnHome_Success) = {
    Call(PlayerYieldTurn)
    Call(UseBattleCamPreset, BTL_CAM_RETURN_HOME)
    Call(MoveBattleCamOver, 5)
    Call(func_802693F0)
    Wait(20)
    Call(EnablePlayerBlur, ACTOR_BLUR_RESET)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
    Wait(5)
    Call(SetGoalToHome, ACTOR_PLAYER)
    Call(SetActorSpeed, ACTOR_PLAYER, Float(8.0))
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Run)
    Call(PlayerRunToGoal, 0)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
    Return
    End
};

EvtScript N(EVS_Hammer_ReturnHome_B) = {
    Call(PlayerYieldTurn)
    Call(func_802693F0)
    Wait(20)
    Call(EnablePlayerBlur, ACTOR_BLUR_RESET)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
    Wait(5)
    Call(SetGoalToHome, ACTOR_PLAYER)
    Call(SetActorSpeed, ACTOR_PLAYER, Float(8.0))
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Run)
    Call(PlayerRunToGoal, 0)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
    Return
    End
};

EvtScript N(EVS_HammerSupport_ReturnHome_Miss) = {
    Call(PlayerYieldTurn)
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_MISTAKE)
    Call(func_802693F0)
    Wait(20)
    Call(EnablePlayerBlur, ACTOR_BLUR_RESET)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
    Wait(5)
    Call(SetGoalToHome, ACTOR_PLAYER)
    Call(SetActorSpeed, ACTOR_PLAYER, Float(8.0))
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Run)
    Call(PlayerRunToGoal, 0)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_Mario1_Idle)
    Return
    End
};

EvtScript N(EVS_UseBasicHammer) = {
    Call(LoadActionCommand, ACTION_COMMAND_SMASH)
    Call(action_command_hammer_init)
    ExecWait(N(EVS_HammerSupport_SmashApproach))
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    ExecWait(N(EVS_HammerSupport_BasicRaiseDelay))
    Call(PlayerTestEnemy, LVar0, DAMAGE_TYPE_SMASH, 0, 0, 0, 16)
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_AIM_HAMMER)
    Call(SetBattleCamOffsetY, 8)
    Call(InitTargetIterator)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_WINDUP)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_PullBack)
    Wait(4)
    Call(N(IsBerserkerEquipped))
    IfNe(LVar0, HIT_RESULT_HIT)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold1)
        Call(GetActionCommandMode, LVar0)
        IfLt(LVar0, 2)
            Call(N(ShouldMovesAutoSucceed))
            IfEq(LVar0, 0)
                Loop(45)
                    Wait(1)
                    Call(CheckStickButtonDown, LVar0)
                    IfNe(LVar0, FALSE)
                        BreakLoop
                    EndIf
                EndLoop
            EndIf
        EndIf
        Add(LVarD, 6)
        Call(action_command_hammer_start, 0, LVarD, 3)
        Call(SetActionQuality, 0)
        Set(LVar1, 0)
        Loop(30)
            Wait(1)
            Call(GetActionQuality, LVar0)
            IfNe(LVar0, 0)
                IfNe(LVar1, 1)
                    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold2)
                    Set(LVar1, 1)
                EndIf
            EndIf
            Call(CheckStickButtonDown, LVar0)
            IfEq(LVar0, FALSE)
                BreakLoop
            EndIf
        EndLoop
        Label(0)
            Call(GetActionCommandMode, LVar0)
            IfLt(LVar0, 2)
                Wait(1)
                Call(GetActionSuccess, LVar0)
                IfEq(LVar0, 0)
                    Goto(0)
                EndIf
            EndIf
    Else
        Call(action_command_hammer_start, 0, LVar1, 3)
        Call(SetActionQuality, 0)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold1)
        Sub(LVar1, 10)
        Wait(LVar1)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold2)
        Wait(5)
    EndIf
    Call(GetActionCommandMode, LVar0)
    IfEq(LVar0, 2)
        Call(SetActionCommandMode, 3)
        Loop(0)
            Call(GetActionCommandMode, LVar0)
            IfLt(LVar0, 2)
                BreakLoop
            EndIf
            Wait(1)
        EndLoop
    EndIf
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_PreSwing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_SWING_1)
    Wait(3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Swing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_STRIKE_1)
    Return
    End
};

EvtScript N(EVS_UseSuperHammer) = {
    Call(LoadActionCommand, ACTION_COMMAND_SMASH)
    Call(action_command_hammer_init)
    ExecWait(N(EVS_HammerSupport_SmashApproach))
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    ExecWait(N(EVS_HammerSupport_SuperRaiseDelay))
    Call(PlayerTestEnemy, LVar0, DAMAGE_TYPE_SMASH, 0, 0, 0, BS_FLAGS1_INCLUDE_POWER_UPS)
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_AIM_HAMMER)
    Call(SetBattleCamOffsetY, 8)
    Call(InitTargetIterator)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_WINDUP)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_PullBack)
    Wait(4)
    Call(N(IsBerserkerEquipped))
    IfEq(LVar0, TRUE)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Hold1)
        Call(N(ShouldMovesAutoSucceed))
        IfEq(LVar0, HIT_RESULT_HIT)
            Loop(45)
                Wait(1)
                Call(CheckStickButtonDown, LVar0)
                IfNe(LVar0, FALSE)
                    BreakLoop
                EndIf
            EndLoop
        EndIf
        Add(LVarD, 6)
        Call(action_command_hammer_start, 0, LVarD, 3)
        Call(SetActionQuality, 0)
        Set(LVar1, 0)
        Loop(30)
            Wait(1)
            Call(GetActionQuality, LVar0)
            IfNe(LVar0, 0)
                IfNe(LVar1, 1)
                    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Hold2)
                    Set(LVar1, 1)
                EndIf
            EndIf
            Call(CheckStickButtonDown, LVar0)
            IfEq(LVar0, FALSE)
                BreakLoop
            EndIf
        EndLoop
        Label(0)
            Wait(1)
            Call(GetActionSuccess, LVar0)
            IfEq(LVar0, 0)
                Goto(0)
            EndIf
    Else
        Call(action_command_hammer_start, 0, LVar1, 3)
        Call(SetActionQuality, 0)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Hold1)
        Sub(LVar1, 10)
        Wait(LVar1)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Hold2)
        Wait(5)
    EndIf
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_PreSwing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_SWING_2)
    Wait(3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Swing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_STRIKE_2)
    Return
    End
};

EvtScript N(EVS_UseUltraHammer) = {
    Call(LoadActionCommand, ACTION_COMMAND_SMASH)
    Call(action_command_hammer_init)
    ExecWait(N(EVS_HammerSupport_SmashApproach))
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    ExecWait(N(EVS_HammerSupport_UltraRaiseDelay))
    Call(PlayerTestEnemy, LVar0, DAMAGE_TYPE_SMASH, 0, 0, 0, BS_FLAGS1_INCLUDE_POWER_UPS)
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_AIM_HAMMER)
    Call(SetBattleCamOffsetY, 8)
    Call(InitTargetIterator)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_WINDUP)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_PullBack)
    Wait(4)
    Call(N(IsBerserkerEquipped))
    IfEq(LVar0, TRUE)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Hold1)
        Call(N(ShouldMovesAutoSucceed))
        IfEq(LVar0, HIT_RESULT_HIT)
            Loop(45)
                Wait(1)
                Call(CheckStickButtonDown, LVar0)
                IfNe(LVar0, FALSE)
                    BreakLoop
                EndIf
            EndLoop
        EndIf
        Add(LVarD, 6)
        Call(action_command_hammer_start, 0, LVarD, 3)
        Call(SetActionQuality, 0)
        Set(LVar1, 0)
        Loop(30)
            Wait(1)
            Call(GetActionQuality, LVar0)
            IfNe(LVar0, 0)
                IfNe(LVar1, 1)
                    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Hold2)
                    Set(LVar1, 1)
                EndIf
            EndIf
            Call(CheckStickButtonDown, LVar0)
            IfEq(LVar0, FALSE)
                BreakLoop
            EndIf
        EndLoop
        Label(0)
            Wait(1)
            Call(GetActionSuccess, LVar0)
            IfEq(LVar0, 0)
                Goto(0)
            EndIf
    Else
        Call(action_command_hammer_start, 0, LVar1, 3)
        Call(SetActionQuality, 0)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Hold1)
        Sub(LVar1, 10)
        Wait(LVar1)
        Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Hold2)
        Wait(5)
    EndIf
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_PreSwing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_SWING_3)
    Wait(3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Swing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_STRIKE_3)
    Return
    End
};

EvtScript N(EVS_Hammer_UseBasicQuake) = {
    Call(ChooseNextTarget, ITER_LAST, LVar0)
    Call(LoadActionCommand, ACTION_COMMAND_SMASH)
    Call(action_command_hammer_init)
    ExecWait(N(EVS_HammerSupport_QuakeApproach))
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    ExecWait(N(EVS_HammerSupport_BasicRaiseDelay))
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_AIM_HAMMER)
    Call(AddBattleCamDist, 80)
    Call(InitTargetIterator)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_WINDUP)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_PullBack)
    Wait(8)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold1)
    Call(N(ShouldMovesAutoSucceed))
    IfEq(LVar0, 0)
        Loop(45)
            Wait(1)
            Call(CheckStickButtonDown, LVar0)
            IfNe(LVar0, FALSE)
                BreakLoop
            EndIf
        EndLoop
    EndIf
    Add(LVarD, 6)
    Call(action_command_hammer_start, 0, LVarD, 3)
    Call(SetActionQuality, 0)
    Set(LVar1, 0)
    Loop(30)
        Wait(1)
        Call(GetActionQuality, LVar0)
        IfNe(LVar0, 0)
            IfNe(LVar1, 1)
                Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Hold2)
                Set(LVar1, 1)
            EndIf
        EndIf
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, FALSE)
            BreakLoop
        EndIf
    EndLoop
    Loop(60)
        Wait(1)
        Call(GetActionSuccess, LVar0)
        IfEq(LVar0, 1)
            BreakLoop
        EndIf
    EndLoop
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_SWING_1)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_PreSwing)
    Wait(3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash1_Swing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_STRIKE_1)
    Return
    End
};

EvtScript N(EVS_Hammer_UseSuperQuake) = {
    Call(ChooseNextTarget, ITER_LAST, LVar0)
    Call(LoadActionCommand, ACTION_COMMAND_SMASH)
    Call(action_command_hammer_init)
    ExecWait(N(EVS_HammerSupport_QuakeApproach))
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    ExecWait(N(EVS_HammerSupport_SuperRaiseDelay))
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_AIM_HAMMER)
    Call(AddBattleCamDist, 80)
    Call(InitTargetIterator)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_WINDUP)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_PullBack)
    Wait(8)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Hold1)
    Call(N(ShouldMovesAutoSucceed))
    IfEq(LVar0, 0)
        Loop(45)
            Wait(1)
            Call(CheckStickButtonDown, LVar0)
            IfNe(LVar0, FALSE)
                BreakLoop
            EndIf
        EndLoop
    EndIf
    Add(LVarD, 6)
    Call(action_command_hammer_start, 0, LVarD, 3)
    Loop(60)
        Wait(1)
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, FALSE)
            BreakLoop
        EndIf
    EndLoop
    Loop(60)
        Wait(1)
        Call(GetActionSuccess, LVar0)
        IfEq(LVar0, 1)
            BreakLoop
        EndIf
    EndLoop
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_SWING_2)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_PreSwing)
    Wait(3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash2_Swing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_STRIKE_2)
    Return
    End
};

EvtScript N(EVS_Hammer_UseUltraQuake) = {
    Call(ChooseNextTarget, ITER_LAST, LVar0)
    Call(LoadActionCommand, ACTION_COMMAND_SMASH)
    Call(action_command_hammer_init)
    ExecWait(N(EVS_HammerSupport_QuakeApproach))
    Call(SetGoalToTarget, ACTOR_PLAYER)
    Call(AddGoalPos, ACTOR_PLAYER, 0, 0, 0)
    ExecWait(N(EVS_HammerSupport_UltraRaiseDelay))
    Call(UseBattleCamPreset, BTL_CAM_PLAYER_AIM_HAMMER)
    Call(AddBattleCamDist, 80)
    Call(InitTargetIterator)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_WINDUP)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_PullBack)
    Wait(8)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Hold1)
    Call(N(ShouldMovesAutoSucceed))
    IfEq(LVar0, 0)
        Loop(45)
            Wait(1)
            Call(CheckStickButtonDown, LVar0)
            IfNe(LVar0, FALSE)
                BreakLoop
            EndIf
        EndLoop
    EndIf
    Add(LVarD, 6)
    Call(action_command_hammer_start, 0, LVarD, 3)
    Loop(60)
        Wait(1)
        Call(CheckStickButtonDown, LVar0)
        IfEq(LVar0, FALSE)
            BreakLoop
        EndIf
    EndLoop
    Loop(60)
        Wait(1)
        Call(GetActionSuccess, LVar0)
        IfEq(LVar0, 1)
            BreakLoop
        EndIf
    EndLoop
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_SWING_3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_PreSwing)
    Wait(3)
    Call(SetAnimation, ACTOR_PLAYER, 0, ANIM_MarioB1_Smash3_Swing)
    Call(PlaySoundAtActor, ACTOR_PLAYER, SOUND_HAMMER_STRIKE_3)
    Return
    End
};
