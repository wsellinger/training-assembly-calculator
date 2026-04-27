*-----------------------------------------------------------
* Title       : CharUtils
* Written by  : Bill Sellinger
* Date        : 07/31/2024
* Description : Tools for working with chars
*-----------------------------------------------------------

;==========================================
;=== Is Numeric =======================

;Determines if the value in the lower byte of d0 is numeric and sets the CCR Zero flag accordingly

;=== Registers ===
;   Input
;   d0 = byte to compare
;
;   Output
;   CCR - Z = bool return

Char_IsNumeric
    ;Check if within range of 0-9
    cmp.b #'0',d0
    blt .False

    cmp.b #'9',d0
    bgt .False

    jsr Set_True
    rts

.False
    jsr Set_False
    rts

;=== Is Numeric =======================
;==========================================

;==========================================
;=== Is In List =======================

;Determines if the value in the lower byte of d0 matches any of the non-zero bytes in the 
;   list at a1 and sets the CCR Zero flag accordingly

;=== Registers ===
;   Input
;   d0 = byte to compare
;   a0 = address of null terminated char list
;
;   Output
;   CCR - Z = bool return

Char_IsInList
    move.l a0,-(sp) ;Save Initial Address

.Loop
    ;If Null, Return False
    cmp.b #0,(a0)
    beq .False

    ;If Match, Return True
    cmp.b (a0)+,d0
    beq .True

    bra .Loop
.False
    jsr Set_False
    bra .Return
.True
    jsr Set_True
    bra .Return
.Return
    move.l (sp)+,a0 ;Reset Address to Start
    rts

;=== Is In List =======================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
