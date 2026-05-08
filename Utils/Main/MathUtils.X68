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
Math_FixDiv

;=== Registers ===
;   Input/Output
;   d1 = Dividend
;   d2 = Divisor
;   d3 = Quotient
;
;   Internal
;   d4 = Remainder
;   d5 = Result Sign
;   d6 = Working
.Registers reg d4-d6

;=== Logic ===
;Math_FixDiv

    ;Save Registers
    movem.l .Registers,-(sp)
    
    ;Set Default Values
    jsr .ClearInternal

    ;Check for Divide by Zero
    tst.l d2
    beq .ThrowDivideByZero

    ;Strip Input Signs, Save Result Sign
    jsr .StripSigns

    ;Binary Long Division to Integer
    move.l #31, d6  ;Loop full Dividend (32 bits)
    jsr .BinLongDiv

    ;Check for Overflow
    jsr .CheckOverflow
    beq .ThrowOverflow

    ;Process Remainder to Fractional
    move.l #15, d6  ;Loop full Fractional (16 bits)
    jsr .BinLongDiv

    ;Apply Result Sign
    jsr .ApplySign

    ;Return
    bra .Return

.ThrowDivideByZero
    move.l #0,d3            ;Return 0 on divide by zero
    or #CCR_Carry,ccr       ;Set Carry Flag to indicate error
    bra .Return

.ThrowOverflow
    move.l #0,d3            ;Return 0 on overflow
    or #CCR_OverFlow,ccr    ;Set Overflow Flag

.Return
    ;Restore Registers
    movem.l (sp)+,.Registers

    ;Return
    rts

;--- Local Subroutines --------------------

;--- Clear Internal
.ClearInternal
    clr.l d4
    clr.l d5
    clr.l d6
    rts
;------

;--- Strip Signs
.StripSigns
    ;Strip Sign from Dividend
    move.l d1,d0 
    jsr Math_Abs
    move.w SR,d5        ;Save Dividend Sign
    and.l #CCR_Zero,d5  ;Isolate Sign Bit
    move.l d0,d1        ;Save Absolute Value Back to Dividend

    ;Strip Sign from Divisor
    move.l d2,d0 
    jsr Math_Abs
    move.w SR,d6        ;Save Divisor Sign
    and.l #CCR_Zero,d6  ;Isolate Sign Bit
    move.l d0,d2        ;Save Absolute Value Back to Divisor

    ;Determine Result Sign
    eor.l d6,d5         ;If Signs are Different, Result is Negative

    rts
;------

;--- Binary Long Division
.BinLongDiv
    ;Get Next Bit
    asl.l #1, d1            ;Shift Dividend left bit to X (0 during fractional))
    roxl.l #1, d4           ;Rotate X to Remainder
    asl.l #1, d3            ;Shift Quotient left for next bit

    ;Compare        
    cmp.l d4, d2            ;If Divisor > Remainder 
    bhi .DivSkip            ;Result bit stays 0
    sub.l d2, d4            ;Else Subtract Divisor
    add.l #1, d3            ;Set result to 1
.DivSkip
    dbra d6, .BinLongDiv    ;Set Iterator outside loop
    rts
;------

;--- Check Overflow
.CheckOverflow
    swap d3             ;Get overflow bits
    tst.w d3            ;If exceeds word length (overflow bits non-zero )
    bne .OverFlowSkip   ;Return Overflow
    swap d3             ;Else clean up
    jsr Set_False
    rts
.OverFlowSkip
    jsr Set_True
    rts
;------

;--- Apply Result Sign
.ApplySign
    tst.l d5        ;If zero
    beq .SignSkip   ;Positive
    neg.l d3        ;Else Negative
.SignSkip
    rts
;------

;=== Fixed Point Division =============
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~