*-----------------------------------------------------------
* Title       : UnitTests_MathUtils
* Written by  : Bill Sellinger
* Date        : 07/31/2024
* Description : Unit Tests for MathUtils
*-----------------------------------------------------------

;==========================================
;=== Run Tests ========================

UnitTests_Math__RunTests
    jsr Test_Math_MShift10_D1
    jsr Test_Math_MShift10_D4
    jsr Test_Math_DShift_10
    jsr Test_Math_SimpDiv
    jsr Test_Math_Abs
    ;jsr Test_Math_FixDiv
    rts

;=== Run Tests ========================
;==========================================

;==========================================
;=== Math_MulShift_10_D1 ==============

;Given an input number, divides it by 10 and puts the result in the same register

;=== Main Test ===

Test_Math_MShift10_D1
    jsr Test_Math_MShift10_D1_Simp
    jsr Test_Math_MShift10_D1_Min
    jsr Test_Math_MShift10_D1_Min
    jsr Test_Math_MShift10_D1_Max
    rts

;=== Variants ===

;------------------------------------------
;--- Math_MulShift_10_D1 Simple -------

Test_Math_MShift10_D1_Simp
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_MShift10_D1_Base
    rts

;--- Data ---

.Input
    dc.l 1     ;Input
    dc.l 10    ;Expected

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_MShift10_D1_Simp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_MulShift_10_D1 Simple -------
;------------------------------------------

;------------------------------------------
;--- Math_MulShift_10_D1 Min ----------

Test_Math_MShift10_D1_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_MShift10_D1_Base
    rts

;--- Data ---

.Input
    dc.l $8CCCCCCD  ;Input
    dc.l $80000002  ;Expected

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_MShift10_D1_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_MulShift_10_D1 Min ----------
;------------------------------------------

;------------------------------------------
;--- Math_MulShift_10_D1 Max ----------

Test_Math_MShift10_D1_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_MShift10_D1_Base
    rts

;--- Data ---

.Input
    dc.l $0CCCCCCC  ;Input
    dc.l $7FFFFFF8  ;Expected

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_MShift10_D1_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_MulShift_10_D1 Max ----------
;------------------------------------------

;------------------------------------------
;--- Math_MulShift_10_D1 Base ---------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Address to Input in the form of 2 consecutive longs: Input, Expected Result

Test_Math_MShift10_D1_Base
    ;Arrange
    move.l (a6)+,d1 ;Input

    ;Act
    jsr Math_MulShift_10_D1

    ;Assert
    cmp.l (a6)+,d1 ;Expected
    bne .Fail
    rts ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;--- Math_MulShift_10_D1 Base ---------
;------------------------------------------

;=== Math_MulShift_10_D1 ==============
;==========================================

;==========================================
;=== Math_MulShift_10_D4 ==============

;Given an input number, divides it by 10 and puts the result in the same register

;=== Main Test ===

Test_Math_MShift10_D4
    jsr Test_Math_MShift10_D4_Simp
    jsr Test_Math_MShift10_D4_Min
    jsr Test_Math_MShift10_D4_Max
    rts

;=== Variants ===

;------------------------------------------
;--- Math_MulShift_10_D4 Simple -------

Test_Math_MShift10_D4_Simp
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_MShift10_D4_Base
    rts

;--- Data ---

.Input
    dc.l 1     ;Input
    dc.l 10    ;Expected

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_MShift10_D4_Simp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_MulShift_10_D4 Simple -------
;------------------------------------------

;------------------------------------------
;--- Math_MulShift_10_D4 Min ----------

Test_Math_MShift10_D4_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_MShift10_D4_Base
    rts

;--- Data ---

.Input
    dc.l $8CCCCCCD  ;Input
    dc.l $80000002  ;Expected

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_MShift10_D4_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_MulShift_10_D4 Min ----------
;------------------------------------------

;------------------------------------------
;--- Math_MulShift_10_D4 Max ----------

Test_Math_MShift10_D4_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_MShift10_D4_Base
    rts

;--- Data ---

.Input
    dc.l $0CCCCCCC  ;Input
    dc.l $7FFFFFF8  ;Expected

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_MShift10_D4_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_MulShift_10_D4 Max ----------
;------------------------------------------

;------------------------------------------
;--- Math_MulShift_10_D4 Base ---------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Address to Input in the form of 2 consecutive longs: Input, Expected Result

Test_Math_MShift10_D4_Base
    ;Arrange
    move.l (a6)+,d4 ;Input

    ;Act
    jsr Math_MulShift_10_D4

    ;Assert
    cmp.l (a6)+,d4 ;Expected
    bne .Fail
    rts ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;--- Math_MulShift_10_D4 Base ---------
;------------------------------------------

;=== Math_MulShift_10_D4 ==============
;==========================================

;==========================================
;=== Math_DivShift_10 =================

;Given an input number, divides it by 10 and puts the result in the same register

;=== Main Test ===

Test_Math_DShift_10
    jsr Test_Math_DShift_10_Simp
    jsr Test_Math_DShift_10_Big
    jsr Test_Math_DShift_10_Max
    jsr Test_Math_DShift_10_Neg
    rts

;=== Variants ===

;------------------------------------------
;--- Math_DivShift_10 Simple ----------

Test_Math_DShift_10_Simp
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_DShift_10_Base
    rts

;--- Data ---

.Input
    dc.l 10    ;Input
    dc.l 1     ;Expected

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_DShift_10_Simp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_DivShift_10 Simple ----------
;------------------------------------------

;------------------------------------------
;--- Math_DivShift_10 Big -------------

Test_Math_DShift_10_Big
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_DShift_10_Base
    rts

;--- Data ---

.Input
    dc.l $10000    ;Input       ;65536
    dc.l $1999     ;Expected    ;6553

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_DShift_10_Big',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_DivShift_10 Big -------------
;------------------------------------------

;------------------------------------------
;--- Math_DivShift_10 Max -------------

Test_Math_DShift_10_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_DShift_10_Base
    rts

;--- Data ---

.Input
    dc.l $7FFFFFFF  ;Input      ;2147483647
    dc.l $CCCCCCC   ;Expected   ;214748364

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_DShift_10_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_DivShift_10 Max -------------
;------------------------------------------

;------------------------------------------
;--- Math_DivShift_10 Negative --------

Test_Math_DShift_10_Neg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_DShift_10_Base
    rts

;=== Data ===

.Input
    dc.l $FFFFFFF6  ;Input      ;-10
    dc.l $FFFFFFFF  ;Expected   ;-1     

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_DShift_10_Neg',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_DivShift_10 Negative --------
;------------------------------------------

;------------------------------------------
;--- Math_DivShift_10 Min -------------

Test_Math_DShift_10_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_DShift_10_Base
    rts

;--- Data ---

.Input
    dc.l $80000000  ;Input      ;-2147483648  
    dc.l $F3333334  ;Expected   ;-214748364   

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_DShift_10_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_DivShift_10 Min -------------
;------------------------------------------

;------------------------------------------
;--- Math_DivShift_10 Base ------------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Address to Input in the form of 2 consecutive longs: Input, Expected Result

Test_Math_DShift_10_Base
    ;Arrange
    move.l (a6)+,d1 ;Input

    ;Act
    jsr Math_DivShift_10

    ;Assert
    cmp.l (a6),d1 ;Expected
    bne .Fail
    rts ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;--- Math_DivShift_10 Base ------------
;------------------------------------------

;=== Math_DivShift_10 =================
;==========================================

;==========================================
;=== Math_SimpDiv =====================

;Given an input number, divides it by 10 and puts the result in the same register

;=== Main Test ===

Test_Math_SimpDiv
    jsr Test_Math_SimpDiv_NoOp
    jsr Test_Math_SimpDiv_Simp
    jsr Test_Math_SimpDiv_Min
    jsr Test_Math_SimpDiv_Max
    rts

;=== Variants ===

;------------------------------------------
;--- Math_SimpDiv No Operation --------

Test_Math_SimpDiv_NoOp
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_SimpDiv_Base
    rts

;--- Data ---

.Input
    dc.l $2     ;Dividend
    dc.l $1     ;Divisor
    dc.l $2     ;Expected Dividend
    dc.l $1     ;Expected Divisor

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_SimpDiv_NoOp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_SimpDiv No Operation --------
;------------------------------------------

;------------------------------------------
;--- Math_SimpDiv Simp ----------------

Test_Math_SimpDiv_Simp
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_SimpDiv_Base
    rts

;--- Data ---

.Input
    dc.l $0003FFFE  ;Dividend
    dc.l $0001FFFF  ;Divisor
    dc.l $0001FFFF  ;Expected Dividend
    dc.l $0000FFFF  ;Expected Divisor

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_SimpDiv_Simp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_SimpDiv Simp ----------------
;------------------------------------------

;------------------------------------------
;--- Math_SimpDiv Min -----------------

Test_Math_SimpDiv_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_SimpDiv_Base
    rts

;--- Data ---

.Input
    dc.l $80000000  ;Dividend
    dc.l $80000000  ;Divisor
    dc.l $FFFF8000  ;Expected Dividend
    dc.l $FFFF8000  ;Expected Divisor

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_SimpDiv_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_SimpDiv Min -----------------
;------------------------------------------

;------------------------------------------
;--- Math_SimpDiv Max -----------------

Test_Math_SimpDiv_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_SimpDiv_Base
    rts

;--- Data ---

.Input
    dc.l $7FFFFFFF  ;Dividend
    dc.l $7FFFFFFF  ;Divisor
    dc.l $0000FFFF  ;Expected Dividend
    dc.l $0000FFFF  ;Expected Divisor

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_SimpDiv_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_SimpDiv Max -----------------
;------------------------------------------

;------------------------------------------
;--- Math_SimpDiv Base ----------------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Address to Input in the form of 2 consecutive longs: Input, Expected Result

Test_Math_SimpDiv_Base
    ;Arrange
    move.l (a6)+,d1 ;Dividend
    move.l (a6)+,d2 ;Divisor

    ;Act
    jsr Math_SimpDiv

    ;Assert
    cmp.l (a6)+,d1 ;Expected Dividend
    bne .Fail    
    cmp.l (a6)+,d2 ;Expected Divisor
    bne .Fail
    rts ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;--- Math_SimpDiv Base ----------------
;------------------------------------------

;=== Math_SimpDiv =====================
;==========================================

;==========================================
;=== Math_FixDiv ======================

;Given an input number, divides it by 10 and puts the result in the same register

;=== Main Test ===

Test_Math_FixDiv
    jsr Test_Math_FixDiv_Simp
    rts

;=== Variants ===

;------------------------------------------
;--- Math_FixDiv Simple ---------------

Test_Math_FixDiv_Simp
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

;--- Data ---

.Input
    dc.l $00000006     ;Dividend
    dc.l $00000003     ;Divisor
    dc.l $00020000     ;Expected Quotient

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Simp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Math_FixDiv Simple ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Base -----------------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Address to Input in the form of 2 consecutive longs: Input, Expected Result

Test_Math_FixDiv_Base
    ;Arrange
    move.l (a6)+,d1 ;Dividend
    move.l (a6)+,d2 ;Divisor

    ;Act
    jsr Math_FixDiv

    ;Assert
    cmp.l (a6)+,d3 ;Expected Dividend
    bne .Fail
    rts ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;--- Math_FixDiv Base -----------------
;------------------------------------------

;=== Math_FixDiv ======================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
