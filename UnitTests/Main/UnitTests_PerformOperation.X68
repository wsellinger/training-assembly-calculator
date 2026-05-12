*-----------------------------------------------------------
* Title       : UnitTests_PerformOperation
* Written by  : Bill Sellinger
* Date        : 08/01/2024
* Description : Unit Tests for Main.ProcessInput
*-----------------------------------------------------------

;==========================================
;=== Run Tests ========================

UnitTests_PerformOperation
    jsr Test_PerformOperation_Add
    jsr Test_PerformOperation_Sub
    jsr Test_PerformOperation_Mul
    jsr Test_PerformOperation_Div
    jsr Test_PerformOperation_Ovr
    rts

;=== Run Tests ========================
;==========================================

;==========================================
;=== PerformOperation =================

;------------------------------------------
;--- PerformOperation Add -------------

;Given processed add operation input, calculates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Add
    jsr Test_PerfOp_Add_Simple
    jsr Test_PerfOp_Add_Max
    jsr Test_PerfOp_Add_Min
    jsr Test_PerfOp_Add_Dec
    jsr Test_PerfOp_Add_NegNeg
    jsr Test_PerfOp_Add_Cross
    jsr Test_PerfOp_Add_Zero
    rts

;=== Variants ===

;--------------
;--- Simple ---

Test_PerfOp_Add_Simple
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

.Input
    dc.l $00010000
    dc.l $00020000
    dc.b 0,0,0,'+'
    dc.l $00030000

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Add_Simple',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Simple ---
;--------------

;-----------
;--- Max ---

Test_PerfOp_Add_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $7FFFFFFE
    dc.l $00000001
    dc.b 0,0,0,'+'
    dc.l $7FFFFFFF

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Add_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Max ---
;-----------

;-----------
;--- Min ---

Test_PerfOp_Add_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $80000000
    dc.l $00000001
    dc.b 0,0,0,'+'
    dc.l $80000001

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Add_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Min ---
;-----------

;---------------
;--- Decimal ---

Test_PerfOp_Add_Dec
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $000C570A ;12.34
    dc.l $0038C7AE ;56.78
    dc.b 0,0,0,'+'
    dc.l $00451EB8 ;69.12

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Add_Dec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Decimal ---
;---------------

;--------------
;--- NegNeg ---

Test_PerfOp_Add_NegNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $FFFE0000  ;-2.0
    dc.l $FFFD0000  ;-3.0
    dc.b 0,0,0,'+'
    dc.l $FFFB0000  ;-5.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Add_NegNeg',0
    ORG (*+3)&-4

;--- NegNeg ---
;--------------

;-----------------
;--- CrossZero ---

Test_PerfOp_Add_Cross
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $FFFF0000  ;-1.0
    dc.l $00030000  ; 3.0
    dc.b 0,0,0,'+'
    dc.l $00020000  ; 2.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Add_Cross',0
    ORG (*+3)&-4

;--- CrossZero ---
;-----------------

;------------
;--- Zero ---

Test_PerfOp_Add_Zero
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00000000  ; 0.0
    dc.l $00050000  ; 5.0
    dc.b 0,0,0,'+'
    dc.l $00050000  ; 5.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Add_Zero',0
    ORG (*+3)&-4

;--- Zero ---
;-------------

;--- PerformOperation Add -------------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Subtract --------

;Given processed add operation input, calculates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Sub
    jsr Test_PerfOp_Sub_Simple
    jsr Test_PerfOp_Sub_Max
    jsr Test_PerfOp_Sub_Min
    jsr Test_PerfOp_Sub_Dec
    jsr Test_PerfOp_Sub_NegRes
    jsr Test_PerfOp_Sub_NegNeg
    jsr Test_PerfOp_Sub_Zero
    rts

;=== Variants ===

;--------------
;--- Simple ---

Test_PerfOp_Sub_Simple
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00030000
    dc.l $00020000
    dc.b 0,0,0,'-'
    dc.l $00010000

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Sub_Simple',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Simple ---
;--------------

;-----------
;--- Max ---

Test_PerfOp_Sub_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $7FFFFFFF
    dc.l $00000001
    dc.b 0,0,0,'-'
    dc.l $7FFFFFFE

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Sub_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Max ---
;-----------

;-----------
;--- Min ---

Test_PerfOp_Sub_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $80000001
    dc.l $00000001
    dc.b 0,0,0,'-'
    dc.l $80000000

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Sub_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Min ---
;-----------

;---------------
;--- Decimal ---

Test_PerfOp_Sub_Dec
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $0038C7AE ;56.78
    dc.l $000C570A ;12.34
    dc.b 0,0,0,'-'
    dc.l $002C70A4 ;44.44

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Sub_Dec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Decimal ---
;---------------

;-----------------
;--- NegResult ---

Test_PerfOp_Sub_NegRes
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00010000  ; 1.0
    dc.l $00030000  ; 3.0
    dc.b 0,0,0,'-'
    dc.l $FFFE0000  ;-2.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Sub_NegRes',0
    ORG (*+3)&-4

;--- NegResult ---
;-----------------

;--------------
;--- NegNeg ---

Test_PerfOp_Sub_NegNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $FFFE0000  ;-2.0
    dc.l $FFFD0000  ;-3.0
    dc.b 0,0,0,'-'
    dc.l $00010000  ; 1.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Sub_NegNeg',0
    ORG (*+3)&-4

;--- NegNeg ---
;--------------

;------------
;--- Zero ---

Test_PerfOp_Sub_Zero
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00050000  ; 5.0
    dc.l $00050000  ; 5.0
    dc.b 0,0,0,'-'
    dc.l $00000000  ; 0.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Sub_Zero',0
    ORG (*+3)&-4

;--- Zero ---
;------------

;--- PerformOperation Subtract --------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Multiply --------

;Given processed add operation input, calculates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Mul
    jsr Test_PerfOp_Mul_Simple
    jsr Test_PerfOp_Mul_Max
    jsr Test_PerfOp_Mul_Min
    jsr Test_PerfOp_Mul_Dec
    jsr Test_PerfOp_Mul_Zero
    jsr Test_PerfOp_Mul_One
    jsr Test_PerfOp_Mul_NegPos
    jsr Test_PerfOp_Mul_NegNeg
    rts

;=== Variants ===

;--------------
;--- Simple ---

Test_PerfOp_Mul_Simple
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00020000
    dc.l $00030000
    dc.b 0,0,0,'*'
    dc.l $00060000

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_Simple',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Simple ---
;--------------

;-----------
;--- Max ---

Test_PerfOp_Mul_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $3FFFFFFF
    dc.l $00020000
    dc.b 0,0,0,'*'
    dc.l $7FFFFFFE

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Max ---
;-----------

;-----------
;--- Min ---

Test_PerfOp_Mul_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $C0000000
    dc.l $00020000
    dc.b 0,0,0,'*'
    dc.l $80000000

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Min ---
;-----------

;---------------
;--- Decimal ---

Test_PerfOp_Mul_Dec
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $000C570A ;12.34
    dc.l $0038C7AE ;56.78
    dc.b 0,0,0,'*'
    dc.l $02BCAA3B ;700.66 ~700.6652

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_Dec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Decimal ---
;---------------

;------------
;--- Zero ---

Test_PerfOp_Mul_Zero
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00050000  ; 5.0
    dc.l $00000000  ; 0.0
    dc.b 0,0,0,'*'
    dc.l $00000000  ; 0.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_Zero',0
    ORG (*+3)&-4

;--- Zero ---
;------------

;-----------
;--- One ---

Test_PerfOp_Mul_One
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00050000  ; 5.0
    dc.l $00010000  ; 1.0
    dc.b 0,0,0,'*'
    dc.l $00050000  ; 5.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_One',0
    ORG (*+3)&-4

;--- One ---
;-----------

;--------------
;--- NegPos ---

Test_PerfOp_Mul_NegPos
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $FFFD0000  ;-3.0
    dc.l $00020000  ; 2.0
    dc.b 0,0,0,'*'
    dc.l $FFFA0000  ;-6.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_NegPos',0
    ORG (*+3)&-4

;--- NegPos ---
;--------------

;--------------
;--- NegNeg ---

Test_PerfOp_Mul_NegNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $FFFD0000  ;-3.0
    dc.l $FFFE0000  ;-2.0
    dc.b 0,0,0,'*'
    dc.l $00060000  ; 6.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_NegNeg',0
    ORG (*+3)&-4

;--- NegNeg ---
;--------------

;--- PerformOperation Multiply --------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Divide ----------

;Given processed add operation input, calculates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Div
    jsr Test_PerfOp_Div_Int
    jsr Test_PerfOp_Div_Fix
    jsr Test_PerfOp_Div_NegPos
    jsr Test_PerfOp_Div_NegNeg
    jsr Test_PerfOp_Div_ZeroN
    jsr Test_PerfOp_Div_Max
    jsr Test_PerfOp_Div_Min
    jsr Test_PerfOp_Div_Frac
    rts

;=== Variants ===

;-----------
;--- Int ---

Test_PerfOp_Div_Int
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

.Input
    dc.l $00060000     ;Dividend  6.0
    dc.l $00030000     ;Divisor   3.0
    dc.b 0,0,0,'/'
    dc.l $00020000     ;Expected  2.0

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Int',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Int ---
;-----------

;-----------
;--- Fix ---

Test_PerfOp_Div_Fix
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $0003C000     ;Dividend  3.75
    dc.l $00018000     ;Divisor   1.5
    dc.b 0,0,0,'/'
    dc.l $00028000     ;Expected  2.5

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Fix',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Fix ---
;-----------


;--------------
;--- NegPos ---

Test_PerfOp_Div_NegPos
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $FFFA0000  ;-6.0
    dc.l $00030000  ; 3.0
    dc.b 0,0,0,'/'
    dc.l $FFFE0000  ;-2.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_NegPos',0
    ORG (*+3)&-4

;--- NegPos ---
;--------------

;--------------
;--- NegNeg ---

Test_PerfOp_Div_NegNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $FFFA0000  ;-6.0
    dc.l $FFFD0000  ;-3.0
    dc.b 0,0,0,'/'
    dc.l $00020000  ; 2.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_NegNeg',0
    ORG (*+3)&-4

;--- NegNeg ---
;--------------

;----------------------
;--- Zero Numerator ---

Test_PerfOp_Div_ZeroN
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00000000  ; 0.0
    dc.l $00050000  ; 5.0
    dc.b 0,0,0,'/'
    dc.l $00000000  ; 0.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_ZeroN',0
    ORG (*+3)&-4

;--- Zero Numerator ---
;----------------------

;-----------
;--- Max ---

Test_PerfOp_Div_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $7FFF0000  ;32767.0
    dc.l $00010000  ; 1.0
    dc.b 0,0,0,'/'
    dc.l $7FFF0000  ;32767.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Max',0
    ORG (*+3)&-4

;--- Max ---
;-----------

;-----------
;--- Min ---

Test_PerfOp_Div_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $80000000  ;-32768.0
    dc.l $00010000  ; 1.0
    dc.b 0,0,0,'/'
    dc.l $80000000  ;-32768.0     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Min',0
    ORG (*+3)&-4

;--- Min ---
;-----------

;-----------
;--- Frac ---

Test_PerfOp_Div_Frac
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

;--- Data ---

.Input
    dc.l $00010000  ; 1.0
    dc.l $00030000  ; 3.0
    dc.b 0,0,0,'/'
    dc.l $00005555  ;~0.33333     ;Expected

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Frac',0
    ORG (*+3)&-4

;--- Frac ---
;-----------

;--- PerformOperation Divide ----------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Overflow --------

;Given an operation that causes an error, verifies Set_False is returned

;=== Main Test ===

Test_PerformOperation_Ovr
    jsr Test_PerfOp_Div_Zero
    jsr Test_PerfOp_Div_OvrPos
    jsr Test_PerfOp_Div_OvrNeg
    jsr Test_PerfOp_Mul_Ovr
    rts

;=== Variants ===

;----------------
;--- Div Zero ---

Test_PerfOp_Div_Zero
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerfOp_Err_Base
    rts

;--- Data ---

.Input
    dc.l $00010000          ;Dividend  1.0
    dc.l $00000000          ;Divisor   0.0
    dc.b 0,0,0,'/'

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Zero',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Div Zero ---
;----------------

;-------------------
;--- Div Ovr Pos ---

;32767.5 / 0.5 = 65535.0, integer part exceeds max

Test_PerfOp_Div_OvrPos
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerfOp_Err_Base
    rts

;--- Data ---

.Input
    dc.l $7FFF8000          ;Dividend  32767.5
    dc.l $00008000          ;Divisor   0.5
    dc.b 0,0,0,'/'

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_OvrPos',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Div Ovr Pos ---
;-------------------

;-------------------
;--- Div Ovr Neg ---

;-32767.5 / 0.5 = -65535.0, integer part exceeds min

Test_PerfOp_Div_OvrNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerfOp_Err_Base
    rts

;--- Data ---

.Input
    dc.l $80018000          ;Dividend  -32767.5
    dc.l $00008000          ;Divisor   0.5
    dc.b 0,0,0,'/'

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_OvrNeg',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Div Ovr Neg ---
;-------------------

;-------------------
;--- MulOverflow ---

Test_PerfOp_Mul_Ovr
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerfOp_Err_Base
    rts

;--- Data ---

.Input
    dc.l $7FFF0000  ;32767.0
    dc.l $00020000  ; 2.0
    dc.b 0,0,0,'*'

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Mul_Ovr',0
    ORG (*+3)&-4

;--- MulOverflow ---
;-------------------

;--- PerformOperation Overflow --------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Base ------------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Address to Input in the form of 4 consecutive longs: Left Operand, Right Operand, Operator, Expected Result

Test_PerformOperation_Base
    ;Arrange
    move.l (a6)+,d5 ;Left Operand
    move.l (a6)+,d6 ;Right Operand
    move.l (a6)+,d7 ;Operator

    ;Act
    jsr PerformOperation

    ;Assert
    cmp.l (a6),d1 ;Expected
    bne .Fail
    rts ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;--- PerformOperation Base ------------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Error Base ------

;Verifies PerformOperation returns Set_False (Z=0) for error cases
;
;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Address to Input: Left Operand, Right Operand, Operator (3 longs)

Test_PerfOp_Err_Base
    ;Arrange
    move.l (a6)+,d5     ;Left Operand
    move.l (a6)+,d6     ;Right Operand
    move.l (a6)+,d7     ;Operator

    ;Act
    jsr PerformOperation

    ;Assert sexpect Set_False (Z=0), fail if Set_True (Z=1)
    beq .Fail
    rts

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts

;--- PerformOperation Error Base ------
;------------------------------------------

;=== PerformOperation =================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
