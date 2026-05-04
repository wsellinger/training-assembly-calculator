*-----------------------------------------------------------
* Title       : Main
* Written by  : Bill Sellinger
* Date        : 07/31/2024
* Description : Main logic for Exercise 8 - FixedPoint
*-----------------------------------------------------------

;==========================================
;=== Includes =============================
;==========================================

    INCLUDE "Utils/Utils_All.X68"

;==========================================
;=== Constants ============================
;==========================================

;==========================================
;=== Data =================================
;==========================================

Main_ErrorMsgPtr ds.l 1

;==========================================
;=== Main =================================
;==========================================
MAIN
    ;Get Input
    jsr GetInput
    bne .Error

    ;Process Input
    jsr ProcessInput

    ;Perform Operation
    jsr PerformOperation

    ;Display Output
    jsr DisplayResult

    ;Return
    rts

.Error
    lea Main_ErrorMsgPtr,a0
    move.l (a0),a1
    jsr Trap_DisplayString_LB
    rts

;=== Data ===

;==========================================
;=== Subroutines ==========================
;==========================================

;==========================================
;=== Get Input ========================

;Displays a prompt and gets input from the user

;=== Registers ===
;   Internal
;   a1 = trap
;   d0 = trap
;
;   Output
;   a1 = Input String

GetInput
    ;Display Prompt
    lea .Prompt_1,a1
    jsr Trap_DisplayString_LB
    lea .Prompt_2,a1
    jsr Trap_DisplayString_LB
    lea .Prompt_3,a1
    jsr Trap_DisplayString_LB

    ;Capture Input
    lea .Operation,a1
    jsr Trap_CaptureString

    ;Validate
    ;Operation Min Length 3
    cmp.w #3,d1 
    blt .Error

    ;Return
    jsr Set_True
    rts

.Error
    lea .ErrorMsg,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    rts

;=== Data ===
.Prompt_1  
    dc.b 'Input operation in format of Operand Operator Operand (eg. a + b),',CR,LF
    dc.b 'spaces are ignored',0
.Prompt_2
    dc.b 'Operations are constrained to signed 16-bit fixed point values meaning',0
.Prompt_3
    dc.b 'Operands and Results must maintain values between -32768.65535 and 32767.65535.',CR,LF 
    dc.b 'Operators + - * / are supported',0

.Operation ds.b 25

.ErrorMsg dc.b 'Invalid Input - Input must be at least 3 characters long',0

    ORG (*+3)&-4 ;Force Long Word alignment
    
;=== Get Input ========================
;==========================================

;==========================================
;=== Process Input ====================

;Splits the string in a1 into d5-d7

;=== Registers ===
;   Internal
;   d0 = Current Byte
;   d1 = Current Num
;   d2 = Is Negative
;   d3 = Precision
;   d4 = Temp Storage
;   a0 = Operator List
;
;   Input
;   a1 = Input String
;
;   Output
;   d5 = Left Operand
;   d6 = Right Operand
;   d7 = Operator

;=== Logic ===

ProcessInput
    ;Load Operators
    lea .Operators,a0

.LoopOperation
    ;Set Default Values
    jsr .ClearInternal

    ;Check for negative
    jsr .CheckNegative

.LoopOperand
    ;Get Current Byte and Advance Pointer
    move.b (a1)+,d0

    ;If Current Byte is numeric
    jsr Char_IsNumeric
    beq .IsNumeric

    ;Else If Current Byte is Decimal Point
    cmp.b #'.',d0
    beq .IsDecimalPoint

    ;Else If Current Byte is Operator
    jsr Char_IsInList
    beq .IsOperator

    ;Else If Current Byte is Space
    cmp.b #' ',d0
    beq .LoopOperand    ;Ignore Spaces

    ;Else If Current Byte is Null Terminator
    cmp.b #0,d0
    beq .IsEnd

    ;Else Error Invalid Character
    bra .Error_BadChar

.IsNumeric
    ;Convert to Number
    sub.b #48,d0

    ;Shift Destination Up 1 Decimal Place
    muls #10,d1 ;TODO optimize to use bit shifting? (<<3 + <<1) test to see if it's actually faster

    ;If Overflow ;TODO implement
        ;Error too many digits
    
    ;Add to Destination
    add.w d0,d1 

    jsr .UpdatePrecision

    bra .LoopOperand

.IsDecimalPoint
    ;If Precision is already in use (not FFFFFFFF) ;TODO implement
        ;Error Too Many Decimals in Operand

    ;Store Whole Value
    jsr .StoreCurOp

    ;Activate Precision Count
    move.l #0,d3

    bra .LoopOperand

.IsOperator
    ;If Operator Already Stored ;TODO implement
        ;Error, Too Many Operators

    ;Store Operator
    move.b d0,d7

    ;End Operand

    ;Validate ;TODO implement
    ;ensure correct value size
    
    ;Store Operand
    jsr .StoreLeftOp

    bra .LoopOperation

.IsEnd
    ;Store Operand
    jsr .StoreRightOp

    ;Validate
    ;ensure we have 2 operands and an operator ;TODO implement

    rts

;--- Local Subroutines --------------------

;--- Clear Internal
.ClearInternal
    clr.l d0
    clr.l d1
    clr.l d2
    move.l #.PrecisionDefault,d3 ;use max as default as 0 is a valid precision 
    clr.l d4
    rts
;------

;--- Check Negative
.CheckNegative
    cmp.b #'-',(a1)
    bne .NotNegative
    move.b #1,d2                ;Set isNegative
    add.l #1,a1                 ;Advance Pointer
.NotNegative
    rts
;------

;--- Update Precision
.UpdatePrecision
    ;If Precision
    cmp.l #.PrecisionDefault,d3 ;If Whole
    bne .IncPrecision           ;Else Fractional
    rts
    
    ;Increment Precision
.IncPrecision
    add.w #1,d3                 ;Increment
    rts
;------

;--- Store Current Operand
.StoreCurOp
    cmp.b #0,d7
    bne .StoreCurRight
;StoreCurLeft
    jsr .StoreLeftOp
    rts
.StoreCurRight
    jsr .StoreRightOp    
    rts
;------

;--- Store Left Operand
.StoreLeftOp
    jsr .StoreOpConvert
    add.l d1,d5
    clr.l d1
    rts
;------

;--- Store Right Operand
.StoreRightOp
    jsr .StoreOpConvert
    add.l d1,d6
    clr.l d1
    rts
;------

;--- Convert Operand
.StoreOpConvert
    swap d1                     ;Swap, if whole it needs to be in the top, if fractional it needs to be shifted down from the top

    ;Check Precision
    cmp.l #.PrecisionDefault,d3 ;If Whole
    bne .ConvertFract           ;Else Fractional
    
;ConvertWhole
    jsr .ProcessNegatives
    rts

.ConvertFract
    jsr .ProcessFract
    rts
;------

;--- Process Negatives
.ProcessNegatives
    cmp.b #1,d2                 ;If Negative
    beq .ConvertToNeg
    rts
.ConvertToNeg
    sub.l d1,d4
    move.l d4,d1
    clr.l d4
    rts
;------

;--- Process Fractional
.ProcessFract
.ProcessFractWhile
    dbra d3,.ProcessFractDo     ;While Precision    (check conditional first, don't want to shift if no precision, also removes need to pre decrement)
    rts                         ;Else Exit Loop
.ProcessFractDo                 ;Do Shift
    jsr Math_DivShift_10        ;Divide D1 by 10 using shifting math to allow operations above word boundary
    bra .ProcessFractWhile      ;Loop
;------

;--- Errors -------------------------------

.Error_BadChar
    ;TODO lea error msg
    jsr Set_False
    rts

.Error_OneOp
    ;TODO lea error msg
    jsr Set_False
    rts

.Error_OneDec
    ;TODO lea error msg
    jsr Set_False
    rts

;=== Data ===
.PrecisionDefault equ $FFFFFFFF

.Operators dc.b '+-*/',0
    ORG (*+3)&-4 ;Force Long Word alignment
    
;=== Process Input ====================
;==========================================

;==========================================
;=== Perform Operation ================

;Calculates the result of the equation specified by the input values

;=== Registers ===
;   Internal
;   d2 = Temp Storage
;   d3 = Temp Storage
;
;   Input
;   d5 = Left Operand
;   d6 = Right Operand
;   d7 = Operator
;
;   Output
;   d1 = Result

PerformOperation
    ;If Addition
    cmp.b #'+',d7
    beq .Add
    
    ;If Subtraction
    cmp.b #'-',d7
    beq .Sub

    ;If Multiplication
    cmp.b #'*',d7
    beq .Mul
    
    ;If Division
    cmp.b #'/',d7
    beq .Div

.Add
    ;Load Left Operand
    move.l d5,d1
    add.l d6,d1
    bra .Result

.Sub
    ;Load Left Operand
    move.l d5,d1
    sub.l d6,d1
    bra .Result

.Mul
    ;TODO check for overflows?
    
    ;Multiply Fractional
    clr.l d2        ;Clear Left Temp
    clr.l d3        ;Clear Right Temp
    move.w d5,d2    ;Get Left Fractional
    move.w d6,d3    ;Get Right Fractional
    mulu d3,d2      ;Multiply Fractional (Adds Precision)
    clr.w d2        ;Clear Result Fractional
    swap d2         ;Move Result Whole to Fractional
    move.l d2,d1    ;Move Result to Output

    ;Multiply Whole
    clr.l d2        ;Clear Left Temp
    clr.l d3        ;Clear Right Temp
    move.l d5,d2    ;Get Left Whole
    clr.w d2        ;  (Clear Fractional)
    swap d2         ;  (Remove Precision)
    move.l d6,d3    ;Get Right Whole
    clr.w d3        ;  (Clear Fractional)
    swap d3         ;  (Remove Precision)
    muls d3,d2      ;Multiply Wholes
    swap d2         ;  (Add Precision)
    clr.w d2        ;  (Clear Fractional)
    add.l d2,d1     ;Add to Output

    ;Multiply Across: Left Whole to Right Fractional
    clr.l d2        ;Clear Left Temp
    clr.l d3        ;Clear Right Temp
    move.l d5,d2    ;Get Left Whole
    clr.w d2        ;  (Clear Fractional)
    swap d2         ;  (Remove Precision)
    move.w d6,d3    ;Get Right Fractional
    mulu d3,d2      ;Multiply Parts (Adds Precision)
    add.l d2,d1     ;Add to Output

    ;Multiply Across: Left Fractional to Right Whole
    clr.l d2        ;Clear Left Temp
    clr.l d3        ;Clear Right Temp
    move.w d5,d2    ;Get Left Fractional
    move.l d6,d3    ;Get Right Whole
    clr.w d3        ;  (Clear Fractional)
    swap d3         ;  (Remove Precision)
    mulu d3,d2      ;Multiply Parts (Adds Precision)
    add.l d2,d1     ;Add to Output
    
    bra .Result

.Div
    move.l d5,d1    ;Get Left
    move.l d6,d2    ;Get Right

    ;TODO check for div by 0

    ;Simplify Divisor
    jsr Math_SimpDiv

    ;Fixed Point Division
    jsr Math_FixDiv
    move.l d3,d1

.Result
    ;Validate Result
    ;TODO check for overflow V flag

    ;Return
    rts

;=== Data ===
    
;=== Perform Operation ================
;==========================================

;==========================================
;=== Display Result ===================

;Performs final transformations and displays the result to the user

;=== Registers ===
;   Internal
;   d0 = Trap
;
;   Input
;   d1 = Result

DisplayResult
    ;TODO implement decimal display
    ;TODO round up/down when fractional part lost precision?

    jsr Trap_DisplayNum
    rts

;=== Data ===
    
;=== Display Result ===================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
