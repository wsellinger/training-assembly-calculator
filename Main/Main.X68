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
    ;Display Banner
    jsr DisplayBanner

.Loop
    ;Clean State
    jsr ClearRegisters

    ;Get Input
    jsr GetInput
    bne .Error

    ;Process Input
    jsr ProcessInput
    bne .Error

    ;Perform Operation
    jsr PerformOperation
    bne .Error

    ;Display Output
    jsr DisplayResult

    ;Loop for next input
    bra .Loop

.Error
    lea Main_ErrorMsgPtr,a0
    move.l (a0),a1
    jsr Trap_DisplayString_LB
    jsr Trap_DisplayLinebreak
    bra .Loop

;=== Data ===

;==========================================
;=== Subroutines ==========================
;==========================================

;==========================================
;=== Display Banner ===================

;Displays the banner for the program, including title, instructions, and limits

;=== Subroutine ===
DisplayBanner

;=== Registers ===
;   Internal
;   a1 = Temp Storage

;=== Logic ===
;Display Banner

    ;Display Title
    lea .Title,a1
    jsr Trap_DisplayString
    
    ;Display Description
    lea .Description,a1    
    jsr Trap_DisplayString_LB
    
    ;Display Limits
    lea .Limits,a1
    jsr Trap_DisplayString_LB

    ;Return
    rts

;=== Data ===
.Title dc.b 'Fixed Point Calculator',CR,LF,0
.Description 
    dc.b 'This calculator supports addition, subtraction, multiplication, and division',CR,LF
    dc.b 'of signed fixed point numbers with up to 5 decimal places.',CR,LF,0
.Limits     
    dc.b 'Operation Format: a + b',CR,LF
    dc.b 'Supported Operators: + - * /',CR,LF
    dc.b 'Supported Range: -32768 <= Value < 32768.',CR,LF
    dc.b 'Supported Precision: Up to 4 decimal places.',CR,LF,0

    ORG (*+3)&-4 ;Force Long Word alignment

;=== Display Banner ===================
;==========================================


;==========================================
;=== Get Input ========================

;Displays a prompt and gets input from the user

;=== Subroutine ===
GetInput

;=== Registers ===
;   Internal
;   a0 = Temp Storage
;   a1 = trap
;   d0 = trap
;
;   Output
;   a1 = Input String

;=== Logic ===
;GetInput

    ;Capture Input
    lea .Operation,a1
    jsr Trap_CaptureString

    ;Validate
    ;Operation Min Length 3
    cmp.w #3,d1 
    blt .Error

    jsr Set_True
    bra .Return

.Error
    lea .ErrorMsg_InvalidInput,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    bra .Return

.Return
    ;Return
    rts

;=== Data ===
.Operation ds.b 25

.ErrorMsg_InvalidInput dc.b 'Invalid Input - Input must be at least 3 characters long',0

    ORG (*+3)&-4 ;Force Long Word alignment
    
;=== Get Input ========================
;==========================================

;==========================================
;=== Process Input ====================

;Splits the string in a1 into d5-d7

;=== Subroutine ===
ProcessInput

;=== Registers ===
;   Internal
;   d0 = Current Byte
;   d1 = Current Num
;   d2 = Is Negative
;   d3 = Precision
;   d4 = Process Negative
;   a0 = Temp Storage
;
;   Input
;   a1 = Input String
;
;   Output
;   d5 = Left Operand
;   d6 = Right Operand
;   d7 = Operator

;=== Logic ===
;ProcessInput

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
    mulu #10,d1
    
    ;Add to Destination
    add.l d0,d1
    jsr .IsOver
    beq .Error_Overflow

    jsr .UpdatePrecision

    bra .LoopOperand

.IsDecimalPoint
    ;Ensure only one decimal point
    cmp.l #.PrecisionDefault,d3
    bne .Error_OneDec

    ;Store Whole Value
    jsr .StoreCurOp

    ;Activate Precision Count
    move.l #0,d3

    bra .LoopOperand

.IsOperator   
    ;Ensure only one operator
    tst.l d7
    bne .Error_OneOp

    ;Store Operator
    move.b d0,d7

    ;End Operand

    ;Validate ;TODO implement
    ;ensure correct value size
    
    ;Store Operand
    move.b #1,d4 ;Set to Process Negative for Left Operand
    jsr .StoreLeftOp
    bne .Error_Overflow
    
    bra .LoopOperation

.IsEnd
    ;Store Operand
    move.b #1,d4 ;Set to Process Negative for Right Operand
    jsr .StoreRightOp
    bne .Error_Overflow

    ;Validate
    ;ensure we have 2 operands and an operator ;TODO implement
    
    jsr Set_True
    bra .Return

.Error_BadChar
    lea .ErrorMsg_BadChar,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    bra .Return

.Error_OneDec
    lea .ErrorMsg_OneDec,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    bra .Return

.Error_OneOp
    lea .ErrorMsg_OneOp,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    bra .Return

.Error_Overflow
    lea .ErrorMsg_Over,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    bra .Return

.Return
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
    ;Ignore Leading Spaces
    cmp.b #' ',(a1)             ;If Not Leading Space
    bne .CheckIsNeg             ;Then Check for Negative
    add.l #1,a1                 ;Else Ignore Leading Space
    bra .CheckNegative          ;Loop to Check Next Byte

.CheckIsNeg
    cmp.b #'-',(a1)             ;If Not Negative 
    bne .NotNegative            ;Then Skip
    move.b #1,d2                ;Else Set isNegative
    add.l #1,a1                 ;Advance Pointer
.NotNegative
    rts
;------

;--- Is Overflow
.IsOver
    cmp.l #.PrecisionDefault,d3 ;If not Integer
    bne .CheckFractV            ;Then Fractional

    ;Check Integer Overflow
    ;Check Signed Limit
    cmp.l #$00007FFF,d1         ;If Signed Limit not Exceeded
    ble .IsOver_False           ;Then Not Overflow

    ;Check Edge Case
    cmp.l #$00008000,d1         ;If not -32768
    bne .IsOver_True            ;Then Overflow
    cmp.b #1,d2                 ;If not Negative
    bne .IsOver_True            ;Then Overflow
    bra .IsOver_False           ;Else No Overflow

    ;Check Fractional Overflow
.CheckFractV
    cmp.l #$0000270F,d1         ;If Fractional Part Exceeds Limit (0.9999, or 4 decimal places)
    bhi .IsOver_True            ;Then Overflow

.IsOver_False
    jsr Set_False
    rts
.IsOver_True
    jsr Set_True
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
    add.l d5,d1             ;Combine Integer and Fractional
    jsr .ProcessNegative
    bne .StoreLError
    move.l d1,d5            ;Save Processed Value Back to Left Operand
    clr.l d1
    jsr Set_True
    rts
.StoreLError
    jsr Set_False
    rts
;------

;--- Store Right Operand
.StoreRightOp
    jsr .StoreOpConvert
    add.l d6,d1             ;Combine Integer and Fractional
    jsr .ProcessNegative
    bne .StoreRError
    move.l d1,d6            ;Save Processed Value Back to Right Operand
    clr.l d1
    jsr Set_True
    rts
.StoreRError
    jsr Set_False
    rts
;------

;--- Convert Operand
.StoreOpConvert
    swap d1                     ;Swap, if whole it needs to be in the top, if fractional it needs to be shifted down from the top

    ;Check Precision
    cmp.l #.PrecisionDefault,d3 ;If Whole
    beq .SkipFract              ;Then Skip Fractional Conversion
    jsr .ProcessFract
.SkipFract
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

;--- Process Negative
.ProcessNegative
    tst.b d4            ;If Not Process Negative
    beq .ProcNegReturn  ;Then Return
    tst.b d2            ;If Not Negative
    beq .ProcNegReturn  ;Then Return
    cmp.l #$80000000,d1 ;If Value is already Min Negative
    bhi .ProcNegError   ;Then Error, overflow
    neg.l d1            ;Else Convert to Negative

.ProcNegReturn
    clr.b d4            ;Clear Process Negative
    jsr Set_True
    rts

.ProcNegError
    lea .ErrorMsg_Over,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    rts

;=== Data ===
.PrecisionDefault equ $FFFFFFFF

.Operators dc.b '+-*/',0

.ErrorMsg_BadChar dc.b 'Invalid operation: Invalid character',0
.ErrorMsg_OneDec dc.b 'Invalid operation: Only one decimal point per operand',0
.ErrorMsg_OneOp dc.b 'Invalid operation: Only one operand allowed',0
.ErrorMsg_Over dc.b 'Invalid operation: Number too large',0

    ORG (*+3)&-4 ;Force Long Word alignment
    
;=== Process Input ====================
;==========================================

;==========================================
;=== Perform Operation ================

;Calculates the result of the equation specified by the input values

;=== Subroutine ===
PerformOperation

;=== Registers ===
;   Internal
;   d2 = Temp Storage
;   d3 = Temp Storage
;   a0 = Temp Storage
;   a1 = Temp Storage
;
;   Input
;   d5 = Left Operand
;   d6 = Right Operand
;   d7 = Operator
;
;   Output
;   d1 = Result

;=== Logic ===
;PerformOperation

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
    add.l d6,d1     ;TODO check overflow
    jsr Set_True
    bra .Return

.Sub
    ;Load Left Operand
    move.l d5,d1
    sub.l d6,d1    ;TODO check underflow
    jsr Set_True
    bra .Return

.Mul
    move.l d5,d1        ;Get Left
    move.l d6,d2        ;Get Right

    jsr Math_FixMul
    bvs .Error_Overflow
    move.l d3,d1        ;Move Result to Output

    bra .Return

.Div
    move.l d5,d1        ;Get Left
    move.l d6,d2        ;Get Right

    jsr Math_FixDiv     ;Divide (Handles Precision and Sign)
    bcs .Error_DivZero
    bvs .Error_Overflow
    move.l d3,d1        ;Move Result to Output

    jsr Set_True
    bra .Return

.Error_DivZero
    lea .ErrorMsg_Zero,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    bra .Return

.Error_Overflow
    lea .ErrorMsg_Over,a0
    lea Main_ErrorMsgPtr,a1
    move.l a0,(a1)
    jsr Set_False
    bra .Return

.Return
    ;Validate Result

    ;Return
    rts

;=== Data ===
.ErrorMsg_Zero dc.b 'Invalid operation: Division by zero',0
.ErrorMsg_Over dc.b 'Invalid operation: Overflow',0

    ORG (*+3)&-4 ;Force Long Word alignment
    
;=== Perform Operation ================
;==========================================

;==========================================
;=== Display Result ===================

;Performs final transformations and displays the result to the user

;=== Subroutine ===
DisplayResult

;=== Registers ===
;   Internal
;   d0 = Trap
;   d2 = Temp Storage
;   d3 = Iterator
;   a1 = Temp Storage
;
;   Input
;   d1 = Result

;=== Logic ===
;DisplayResult

    ;Display Sign
    tst.l d1                    ;If Positive
    bge .SkipSign               ;Skip Displaying Sign
    neg.l d1                    ;Else Strip Sign
    lea .NegativeSign,a1        ;Load Negative Sign
    jsr Trap_DisplayString      ;Display Sign
.SkipSign

    ;Display Integer Part
    move.w d1,d2                ;Save Fractional Part
    clr.w d1                    ;Clear Fractional Part
    swap d1                     ;Swap Integer Part to Lower Word
    jsr Trap_DisplayNum         ;Display Integer Part

    ;Check for Fractional
    tst.w d2                    ;If No Fractional
    beq .Return                 ;Exit

    ;Display Decimal Point
    lea .DecimalPoint,a1
    jsr Trap_DisplayString

    ;Convert Fractional
    move.w d2,d1                ;Get Fractional Part
    clr.l d2                    ;Clear Temp Storage
    lea .FractionalBuffer,a1    ;Load Buffer Address
    move.l #3,d3                ;Set Precision (4 Decimal Places)

.LoopFractional
    jsr Math_MulShift_10_D1     ;Shift Next Fractional Digit into Integer
    move.l d1,d2                ;Save Integer Digit
    and.l #$0000FFFF,d1         ;Clear Integer Digit
    swap d2                     ;Swap  Integer Digit to Lower Byte
    add.b #'0',d2               ;Convert to Char
    move.b d2,(a1)+             ;Save Char to Buffer
    dbra d3,.LoopFractional     ;Loop for Precision
    clr.b (a1)                  ;Null Terminate Buffer

.DisplayDecimal
    lea .FractionalBuffer,a1    ;Load Buffer Address
    jsr Trap_DisplayString
    
.Return
    jsr Trap_DisplayLinebreak
    jsr Trap_DisplayLinebreak
    rts

;=== Data ===
.NegativeSign dc.b '-',0
.DecimalPoint dc.b '.',0
.FractionalBuffer ds.b 7 ;4 decimal places plus CR, LF, and null terminator

    ORG (*+3)&-4 ;Force Long Word alignment

;=== Display Result ===================
;==========================================

;==========================================
;=== Clear Registers ==================

;Clears all registers for clean state between calculations

;=== Subroutine ===
ClearRegisters

;=== Logic ===
;ClearRegisters

    clr.l d0
    clr.l d1
    clr.l d2
    clr.l d3
    clr.l d4
    clr.l d5
    clr.l d6
    clr.l d7

    ;Return
    rts

;=== Clear Registers ==================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
