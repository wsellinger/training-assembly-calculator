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
    ;jsr Test_PerformOperation_Div ;TODO implement
    rts

;=== Run Tests ========================
;==========================================

;==========================================
;=== PerformOperation =================

;------------------------------------------
;--- PerformOperation Add -------------

;Given processed add operation input, calulates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Add
    jsr Test_PerfOp_Add_Simple
    jsr Test_PerfOp_Add_Max
    jsr Test_PerfOp_Add_Min
    jsr Test_PerfOp_Add_Dec
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

;--- PerformOperation Add -------------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Subtract --------

;Given processed add operation input, calulates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Sub
    jsr Test_PerfOp_Sub_Simple
    jsr Test_PerfOp_Sub_Max
    jsr Test_PerfOp_Sub_Min
    jsr Test_PerfOp_Sub_Dec
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

;--- PerformOperation Subtract --------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Multiply --------

;Given processed add operation input, calulates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Mul
    jsr Test_PerfOp_Mul_Simple
    jsr Test_PerfOp_Mul_Max
    jsr Test_PerfOp_Mul_Min
    jsr Test_PerfOp_Mul_Dec
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

;--- PerformOperation Multiply --------
;------------------------------------------

;------------------------------------------
;--- PerformOperation Divide ----------

;Given processed add operation input, calulates and returns the correct result

;=== Main Test ===

Test_PerformOperation_Div
    jsr Test_PerfOp_Div_Simple
    jsr Test_PerfOp_Div_Max
    jsr Test_PerfOp_Div_Min
    ;jsr Test_PerfOp_Div_Dec ;TODO Implement
    rts

;=== Variants ===

;--------------
;--- Simple ---

Test_PerfOp_Div_Simple
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_PerformOperation_Base
    rts

.Input
    dc.l 6
    dc.l 3
    dc.b 0,0,0,'/'
    dc.l 2

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Simple',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Simple ---
;--------------

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
    dc.l $7FFF
    dc.l $1249
    dc.b 0,0,0,'/'
    dc.l $7

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

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
    dc.l $8000
    dc.l $4000
    dc.b 0,0,0,'/'
    dc.l $2

.Name
    dc.b 'UnitTests_PerformOperation:Test_PerfOp_Div_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Min ---
;-----------

;--- PerformOperation Divide ----------
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

;=== PerformOperation =================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~