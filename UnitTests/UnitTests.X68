*-----------------------------------------------------------
* Title       : UnitTests
* Written by  : Bill Sellinger
* Date        : 07/31/2024
* Description : Unit Tests for Exercise 8 - FixedPoint
*-----------------------------------------------------------
;==========================================
;=== Includes =============================
;==========================================

    INCLUDE "UnitTests/Main/UnitTests_Main.X68"
    INCLUDE "Utils/UnitTests/UnitTests_Utils.X68"

;=== Global Data ===

UnitTests__FailCount dc.l 0

;==========================================
;=== Run Tests =======================

UnitTests__RunTests
    ;Run Tests
    jsr UnitTests_Main__RunTests
    jsr UnitTests_Utils__RunTests

    ;Cleanup
    jsr UnitTests_ClearRegisters

    ;Check for Failures
    lea UnitTests__FailCount,a0
    move.l (a0),d0
    cmp.l #0,d0
    bne .Failed
    rts

.Failed
    ;Display Fail Message
    lea .FailMsg,a1
    jsr Trap_DisplayString

    ;Display Fail Count
    lea UnitTests__FailCount,a1
    move.l (a1),d1
    jsr Trap_DisplayNum

    ;Display Linebreak
    jsr Trap_DisplayString_LB

    ;Display Halt Message
    lea .HaltMsg,a1
    jsr Trap_DisplayString
    SIMHALT
    rts

;=== Data ===
.FailMsg dc.b 'Tests failed: ',0
.HaltMsg dc.b 'Canceling Execution',0
    ORG (*+3)&-4 ;Force Long Word alignment

;=== Run Tests =======================
;==========================================

;==========================================
;=== Log Failure ======================

;Logs test failures in the format of "Failed: Test Name" where test name is loaded to register a2

;Registers
;   a0 = test name
;   a1 = trap
;   d0 = trap

UnitTests__LogFailure
    ;Display Preface
    lea .Preface,a1
    jsr Trap_DisplayString

    ;Display Test Name
    move.l a0,a1
    jsr Trap_DisplayString_LB

    ;Increment Fail Count
    lea UnitTests__FailCount,a0
    add.l #1,(a0)
    rts

;=== Data ===
.Preface dc.b 'Failed: ',0
    ORG (*+3)&-4 ;Force Long Word alignment

;=== Log Failure ======================
;==========================================

;==========================================
;=== Clear Registers ==================

;Clear all registers for clean testing

UnitTests_ClearRegisters
    clr.l d0
    clr.l d1
    clr.l d2
    clr.l d3
    clr.l d4
    clr.l d5
    clr.l d6
    clr.l d7
    move.l #0,a0
    move.l #0,a2
    move.l #0,a1
    move.l #0,a3
    move.l #0,a4
    move.l #0,a5
    move.l #0,a6
    rts

;=== Clear Registers ==================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
