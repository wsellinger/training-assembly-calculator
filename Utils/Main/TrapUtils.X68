*-----------------------------------------------------------
* Title       : TrapUtils
* Written by  : Bill Sellinger
* Date        : 07/03/2024
* Description : Contains subroutines to simplify trap calls
*-----------------------------------------------------------

;=== Trap ===
;Trap Code
SimControlTrapCode equ 15

;=== Control Characters ===
BEL EQU  $07   ;Bell
BS  EQU  $08   ;Backspace
HT  EQU  $09   ;Tab (horizontal 5 characters)
LF  EQU  $0A   ;Line Feed
VT  EQU  $0B   ;Vertical tab (4 lines)
FF  EQU  $0C   ;Form Feed (Always end printing with a Form Feed.)
CR  EQU  $0D   ;Carriage Return 

;==========================================
;=== Capture String ===================

;Read string from keyboard and store at (A1), NULL (0) terminated, length returned in D1.W (max 80)

;Registers
;   a1 = address to store string
;   d0 = capture string task

Trap_CaptureString
    move.l #2,d0
    trap #SimControlTrapCode
    rts
    
;=== Capture String ===================
;==========================================

;==========================================
;=== Display Signed Decimal ===========

;Display signed number in D1.L in decimal in smallest field.

;Registers
;   d1 = number to display
;   d0 = display string task

Trap_DisplayNum
    move.l #3,d0
    trap #SimControlTrapCode
    rts

;=== Display Signed Decimal ===========
;==========================================

;==========================================
;=== Display String With Linebreak ====

;Display the NULL terminated string at (A1) with CR, LF.

;Registers
;   a1 = string to display
;   d0 = display string task

Trap_DisplayString_LB
    move.l #13,d0
    trap #SimControlTrapCode
    rts
    
;=== Display String With Linebreak ====
;==========================================

;==========================================
;=== Display String ===================

;Display the NULL terminated string at (A1) with no CR, LF.

;Registers
;   a1 = string to display
;   d0 = display string task

Trap_DisplayString
    move.l #14,d0
    trap #SimControlTrapCode
    rts
    
;=== Display String ===================
;==========================================

;==========================================
;=== Display Line Break ===============

;Display a manual line break via Display String

;Registers
;   a1 = CR,LF
;   d0 = display string task

Trap_DisplayLinebreak
    lea .LB,a1
    jsr Trap_DisplayString
    rts

;=== Data ===
.LB dc.b CR,LF,0
    ORG (*+3)&-4 ;Force Long Word alignment
    
;=== Display Line Break ===============
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
