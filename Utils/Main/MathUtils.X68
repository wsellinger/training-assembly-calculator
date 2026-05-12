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
    lsr.l #1,d2
    move.l d2,d3    ;d/2 = .5d
    
    ;q += n >> 2
    move.l d1,d2
    lsr.l #2,d2
    add.l d2,d3     ;3d/4 = .75d
    
    ;q += q >> 4
    move.l d3,d2
    lsr.l #4,d2
    add.l d2,d3     ;51d/64 = .796975d
    
    ;q += q >> 8
    move.l d3,d2
    lsr.l #8,d2
    add.l d2,d3     ;13107d/16384 = .799987...d
    
    ;q += q >> 16
    move.l d3,d2
    lsr.l #8,d2
    lsr.l #8,d2
    add.l d2,d3     ;858993458d/1073741824 = ~.8d

    ;Div by 8
    lsr.l #3,d3     ;q >> 3

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
;=== Strip Signs ======================

;Strips signs from two fixed point values, returns result sign indicator.
;Modifies d6 as temporary sign storage.

;=== Subroutine ===
Math_StripSigns

;=== Registers ===
;   Input/Output
;   d0 = Is Negative
;   d1 = Left
;   d2 = Right
;
;   Internal
;   d3 = Working
;   d4 = Working
.Registers reg d3-d4

;=== Logic ===
;Math_StripSigns

    ;Save Registers
    movem.l .Registers,-(sp)

    ;Strip Left
    move.l d1,d0
    jsr Math_Abs
    move.w SR,d3        ;Save Left Sign
    and.l #CCR_Zero,d3  ;Isolate Zero Bit
    move.l d0,d1        ;Store Absolute Value

    ;Strip Right
    move.l d2,d0
    jsr Math_Abs
    move.w SR,d4        ;Save Right Sign
    and.l #CCR_Zero,d4  ;Isolate Zero Bit
    move.l d0,d2        ;Store Absolute Value

    ;Result 
    eor.l d4,d3         ;Different Signs = Negative
    move.l d3,d0        ;Store result sign in output

    ;Restore Registers
    movem.l (sp)+,.Registers

    rts

;=== Strip Signs ======================
;==========================================

;==========================================
;=== Apply Sign =======================

;Applies a sign to a fixed point result

;=== Subroutine ===
Math_ApplySign

;=== Registers ===
;   Input/Output
;   d0 = Is Negative
;   d3 = Result

;=== Logic ===
;Math_ApplySign

    tst.l d0          ;If Positive
    beq .Positive     ;Then Skip Negation
    tst.l d3          ;If $80000000 (edge case)
    bmi .Positive     ;Then Skip Negation (to prevent false overflow)
    neg.l d3
.Positive
    rts

;=== Apply Sign =======================
;==========================================

;==========================================
;=== Fixed Point Multiplication =======

;Multiplies 2 fixed point numbers and processes the result to fit within
;   fixed point notation

;=== Subroutine ===
Math_FixMul

;=== Registers ===
;   Input/Output
;   d1 = Left Factor
;   d2 = Right Factor
;   d3 = Product
;
;   Internal
;   d0 = Result Sign
;   d4 = Left Factor
;   d5 = Right Factor
.Registers reg d0,d4-d5

;=== Logic ===
;Math_FixMul

    ;Save Registers
    movem.l .Registers,-(sp)

    ;Strip Signs
    jsr Math_StripSigns

    ;Save Absolute Inputs
    move.l d1,d4            ;Left Factor
    move.l d2,d5            ;Right Factor

    ;TODO check overflow

    ;Multiply Fractional
    clr.l d1                ;Clear Left Temp
    clr.l d2                ;Clear Right Temp
    move.w d4,d1            ;Get Left Fractional
    move.w d5,d2            ;Get Right Fractional
    mulu d2,d1              ;Multiply Fractional (Adds Precision)
    clr.w d1                ;Clear Result Fractional
    swap d1                 ;Move Result Whole to Fractional
    move.l d1,d3            ;Move Result to Output

    ;Multiply Whole
    clr.l d1                ;Clear Left Temp
    clr.l d2                ;Clear Right Temp
    move.l d4,d1            ;Get Left Whole
    clr.w d1                ;  (Clear Fractional)
    swap d1                 ;  (Remove Precision)
    move.l d5,d2            ;Get Right Whole
    clr.w d2                ;  (Clear Fractional)
    swap d2                 ;  (Remove Precision)
    muls d2,d1              ;Multiply Wholes
    swap d1                 ;  (Add Precision)
    clr.w d1                ;  (Clear Fractional)
    add.l d1,d3             ;Add to Output

    ;Multiply Across: Left Whole to Right Fractional
    clr.l d1                ;Clear Left Temp
    clr.l d2                ;Clear Right Temp
    move.l d4,d1            ;Get Left Whole
    clr.w d1                ;  (Clear Fractional)
    swap d1                 ;  (Remove Precision)
    move.w d5,d2            ;Get Right Fractional
    mulu d2,d1              ;Multiply Parts (Adds Precision)
    add.l d1,d3             ;Add to Output

    ;Multiply Across: Left Fractional to Right Whole
    clr.l d1                ;Clear Left Temp
    clr.l d2                ;Clear Right Temp
    move.w d4,d1            ;Get Left Fractional
    move.l d5,d2            ;Get Right Whole
    clr.w d2                ;  (Clear Fractional)
    swap d2                 ;  (Remove Precision)
    mulu d2,d1              ;Multiply Parts (Adds Precision)
    add.l d1,d3             ;Add to Output

    ;Check Overflow
    jsr .CheckOverflow
    beq .ThrowOverflow

    ;Apply Sign
    jsr Math_ApplySign

    ;Return
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

;--- Check Overflow
.CheckOverflow
    tst.l d0                ;If Negative
    bne .CheckNegOverflow   ;Then Check Negative Overflow
    tst.l d3                ;If Positive
    bmi .ReturnOverflow     ;Then Check Positive Overflow
    bra .ReturnNoOverflow   ;Else No Overflow
.CheckNegOverflow
    cmp.l #$80000000,d3     ;If <= $80000000
    bhi .ReturnOverflow     ;Then Overflow
.ReturnNoOverflow
    jsr Set_False           ;Else No Overflow
    rts
.ReturnOverflow
    jsr Set_True
    rts
;------

;=== Fixed Point Multiplication =======
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
;   d0 = Result Sign
;   d4 = Remainder
;   d5 = Working
.Registers reg d0,d4-d5

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
    jsr Math_StripSigns

    ;Binary Long Division to Integer
    move.l #31, d5      ;Loop full Dividend (32 bits)
    jsr .BinLongDiv

    ;Check for Overflow
    jsr .CheckOverflow
    beq .ThrowOverflow

    ;Process Remainder to Fractional
    move.l #15, d5      ;Loop full Fractional (16 bits)
    jsr .BinLongDiv

    ;Apply Result Sign
    jsr Math_ApplySign

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
    clr.l d0
    clr.l d4
    clr.l d5
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
    dbra d5, .BinLongDiv    ;Set Iterator outside loop
    rts
;------

;--- Check Overflow
.CheckOverflow
    swap d3             ;Get overflow bits
    tst.w d3            ;If exceeds word length (overflow bits non-zero )
    bne .ReturnOverflow ;Return Overflow
    swap d3             ;Else clean up
    jsr Set_False       ;   No Overflow
    rts
.ReturnOverflow
    jsr Set_True
    rts
;------

;=== Fixed Point Division =============
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
