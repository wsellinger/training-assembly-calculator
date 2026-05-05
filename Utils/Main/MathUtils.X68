*-----------------------------------------------------------
* Title       : MathUtils
* Written by  : Bill Sellinger
* Date        : 10/04/2024
* Description : Tools for working with numbers
*-----------------------------------------------------------

;==========================================
;=== Bitshift Multiply By 10 ==========

;Multiplies a number by 10 using bitshifting
;   n << 3 + n << 1

;=== Subroutine ===
Math_MulShift_10_D1

;=== Registers ===
;   Input/Output
;   d1 = Multiplicand/Product
;
;   Internal
;   d2 = Working
.Registers reg d2

;=== Logic ===
;Math_MulShift_10_D1

    ;Save Registers
    movem.l .Registers,-(sp)

    move.l d1,d2 ;Copy
    asl.l #3,d1 ;n << 3
    asl.l #1,d2 ;n << 1
    add.l d2,d1 ;n << 3 + n << 1

    ;Restore Registers
    movem.l (sp)+,.Registers

    ;Return
    rts

;=== Subroutine ===
Math_MulShift_10_D4

;=== Registers ===
;   Input/Output
;   d4 = Dividend/Result
;
;   Internal
;   d2 = Working
.Registers reg d2

;=== Logic ===
;Math_MulShift_10_D4

    ;Save Registers
    movem.l .Registers,-(sp)

    move.l d4,d2 ;Copy
    asl.l #3,d4 ;n << 3
    asl.l #1,d2 ;n << 1
    add.l d2,d4 ;n << 3 + n << 1

    ;Restore Registers
    movem.l (sp)+,.Registers

    ;Return
    rts

;=== Bitshift Multiply By 10 ==========
;==========================================

;==========================================
;=== Bitshift Divide By 10 ============

;Divides a number by 10 using bitshifting
;   For Input "n"
;   Using right shift division and addition, arrive at ~.8n
;   Using right shift division, divide by 8 to arrive at ~.1n
;   Using left shift multiplication and addition, determine the remainder
;   If the remainder is > 9, round up by 1

;=== Subroutine ===
Math_DivShift_10

;=== Registers ===
;   Input/Output
;   d1 = Dividend/Quotient
;
;   Internal
;   d2 = Working
;   d3 = Quotient
;   d4 = Remainder
.Registers reg d2-d4

;=== Logic ===
;Math_DivShift_10

    ;Save Registers
    movem.l .Registers,-(sp)

    ;Logic
    ;Mult by .8
    ;q =  n >> 1
    move.l d1,d2
    asr.l #1,d2
    move.l d2,d3    ;d/2 = .5d
    
    ;q += n >> 2
    move.l d1,d2
    asr.l #2,d2
    add.l d2,d3     ;3d/4 = .75d
    
    ;q += q >> 4
    move.l d3,d2
    asr.l #4,d2
    add.l d2,d3     ;51d/64 = .796975d
    
    ;q += q >> 8
    move.l d3,d2
    asr.l #8,d2
    add.l d2,d3     ;13107d/16384 = .799987...d
    
    ;q += q >> 16
    move.l d3,d2
    asr.l #8,d2
    asr.l #8,d2
    add.l d2,d3     ;858993458d/1073741824 = ~.8d

    ;Div by 8
    asr.l #3,d3     ;q >> 3

    ;Get Remainder
    move.l d3,d2    ;q
    lsl.l #2,d2     ;q << 2 = 4q
    add.l d3,d2     ;(q << 2) + q = 5q
    lsl.l #1,d2     ;((q << 2) + q) << 1 = 10q
    move.l d1,d4    ;r = d
    sub.l d2,d4     ;r = d - 10q

    ;Round
    cmp.b #9,d4
    bhi .Round
    bra .NoRound    
.Round
    add.l #1,d3
.NoRound

    ;Set Output
    move.l d3,d1

    ;Restore Registers
    movem.l (sp)+,.Registers

    ;Return
    rts

;=== Bitshift Divide By 10 ============
;==========================================

;==========================================
;=== Simplify Divisor =================

;Simplifies a division equation until the divisor is within the Word limit

;=== Subroutine ===
Math_SimpDiv

;=== Registers ===
;   Input/Output
;   d1 = Dividend
;   d2 = Divisor

;=== Logic ===
;Math_SimpDiv

.Loop
    ;Is Divisor Long
    cmp.l #$0000FFFF,d2 ;Greater than Max Value
    bgt .Shift
    cmp.l #$FFFF8000,d2 ;Less than Min Value
    blt .Shift    
    ;Else
    ;Return
    rts

.Shift
    ;Shift Both Down
    asr.l #1,d1
    asr.l #1,d2
    
    ;Loop
    bra .Loop

;=== Simplify Divisor =================
;==========================================

;==========================================
;=== Absolute Value ===================

;Get the absolute value of a number and return if it was negative

;=== Subroutine ===
Math_Abs

;=== Registers ===
;   Input/Output
;   d0 = Input/Absolute Value
;   Output
;   CCR - Z = bool return, True if Negative, False if Positive

;=== Logic ===
;Math_Abs

    ;Check if Negative
    tst.l d0
    bge .Positive

    ;Make Positive
    neg.l d0
    jsr Set_True
    rts

.Positive
    jsr Set_False
    rts    

;=== Absolute Value ===================
;==========================================

;==========================================
;=== Fixed Point Division =============

;Divide 2 fixed point numbers and process the remainder into
;   fixed point notation

;=== Subroutine ===
Math_FixDiv ;TODO Unit Test

;=== Registers ===
;   Input/Output
;   d1 = Dividend
;   d2 = Divisor
;   d3 = Quotient
;
;   Internal
;   d4 = Fractional
;   d5 = Working
.Registers reg d4-d5

;=== Logic ===
;Math_FixDiv

    ;Save Registers
    movem.l .Registers,-(sp)

    ;Divide
    divs d2,d1

    ;TODO check for overflow

    ;Get Quotient
    clr.l d3
    move.w d1,d3
    swap d3

.LoopRem
    ;Get Remainder
    clr.w d1
    swap d1

    ;If Remainder Is Zero
    cmp.w #0,d1
    beq .LoopRemEnd

    ;If Out of fractional bits
    cmp #10000,d4
    bge .LoopRemEnd

.LoopMul
    ;Multiply Remainder and Fractional
    jsr Math_MulShift_10_D1
    jsr Math_MulShift_10_D4

    ;Loop if too small
    cmp.l d1,d2
    blt .LoopMul

    ;Divide Remainder
    divu d2,d1

    ;Save Result
    add.w d1,d4

    ;Loop
    bra .LoopRem
.LoopRemEnd

    ;Convert Fractional
    swap d4
    move.l d4,d1

.LoopFractional
    jsr Math_DivShift_10
    
    ;Loop if too big
    cmp.l #$0000FFFF,d2
    bhi.l .LoopFractional

    add.w d1,d3

    ;Restore Registers
    movem.l (sp)+,.Registers

    ;Return
    rts

;=== Fixed Point Division =============
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~