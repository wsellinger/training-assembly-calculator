*-----------------------------------------------------------
* Title       : UnitTests_ProcessInput
* Written by  : Bill Sellinger
* Date        : 08/01/2024
* Description : Unit Tests for Main.ProcessInput
*-----------------------------------------------------------

;==========================================
;=== Run Tests ========================

UnitTests_ProcessInput
    jsr Test_ProcessInput_Operand_Left
    jsr Test_ProcessInput_Operand_Right
    jsr Test_ProcessInput_Operator
    rts

;=== Run Tests ========================
;==========================================

;==========================================
;=== ProcessInput =====================

;------------------------------------------
;--- ProcessInput Left Operand --------

;Given an operation, populates left operand with expected value

;=== Main Test ===

Test_ProcessInput_Operand_Left
    jsr Test_ProcIn_Opd_L_Simp
    jsr Test_ProcIn_Opd_L_Neg
    jsr Test_ProcIn_Opd_L_Space
    jsr Test_ProcIn_Opd_L_Dec
    rts

;=== Variants ===

;--------------
;--- Simple ---

Test_ProcIn_Opd_L_Simp
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Left_Base
    rts

;--- Data ---

.Expected   dc.l $04D20000
.Input      dc.b '1234+5678',0,0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_L_Simp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Simple ---
;--------------

;----------------
;--- Negative ---

Test_ProcIn_Opd_L_Neg
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Left_Base
    rts

;--- Data ---

.Expected   dc.l $FB2E0000
.Input      dc.b '-1234+5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_L_Neg',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Negative ---
;----------------

;-------------
;--- Space ---

Test_ProcIn_Opd_L_Space
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Left_Base
    rts

;--- Data ---

.Expected   dc.l $04D20000
.Input      dc.b ' 1234 + 5678 ',0,0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_L_Space',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Space ---
;-------------

;---------------
;--- Decimal ---

Test_ProcIn_Opd_L_Dec
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Left_Base
    rts

;--- Data ---

.Expected   dc.l $C570A
.Input      dc.b '12.34 + 5678',0,0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_L_Dec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Decimal ---
;---------------

;------------
;--- Base ---

;--- Registers ---
;   Input
;   a1 = Input
;   a2 = Expected
;   a3 = Name of test for logging

Test_ProcIn_Opd_Left_Base
    ;Arrange
    ;Act
    jsr ProcessInput

    ;Assert
    cmp.l (a2),d5
    bne .Fail
    rts ;Success

.Fail
    move.l a3,a0
    jsr UnitTests__LogFailure
    rts ;Failure
    rts

;--- Base ---
;------------

;--- ProcessInput Left Operand --------
;------------------------------------------

;------------------------------------------
;--- ProcessInput Right Operand -------

;Given an operation, populates right operand with expected value

;=== Main Test ===

Test_ProcessInput_Operand_Right
    jsr Test_ProcIn_Opd_R_Simp
    jsr Test_ProcIn_Opd_R_Neg
    jsr Test_ProcIn_Opd_R_Space
    jsr Test_ProcIn_Opd_R_Dec
    rts

;=== Variants ===

;--------------
;--- Simple ---

Test_ProcIn_Opd_R_Simp
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Right_Base
    rts

;--- Data ---

.Expected   dc.l $162E0000
.Input      dc.b '1234+5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_R_Simp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Simple ---
;--------------

;----------------
;--- Negative ---

Test_ProcIn_Opd_R_Neg
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Right_Base
    rts

;--- Data ---

.Expected   dc.l $E9D20000
.Input      dc.b '1234+-5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_R_Neg',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Negative ---
;----------------

;-------------
;--- Space ---

Test_ProcIn_Opd_R_Space
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Right_Base
    rts

;--- Data ---

.Expected   dc.l $162E0000
.Input      dc.b ' 1234 + 5678 ',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_R_Space',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Space ---
;-------------

;---------------
;--- Decimal ---

Test_ProcIn_Opd_R_Dec
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Right_Base
    rts

;--- Data ---

.Expected   dc.l $38C7AE
.Input      dc.b '1234 + 56.78',0,0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_R_Dec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Decimal ---
;---------------

;------------
;--- Base ---

;--- Registers ---
;   Input
;   a1 = Input
;   a2 = Expected
;   a3 = Name of test for logging

Test_ProcIn_Opd_Right_Base
    ;Arrange
    ;Act
    jsr ProcessInput

    ;Assert
    cmp.l (a2),d6
    bne .Fail
    rts ;Success

.Fail
    move.l a3,a0
    jsr UnitTests__LogFailure
    rts ;Failure
    rts

;--- Base ---
;------------

;--- ProcessInput Right Operand -------
;------------------------------------------

;------------------------------------------
;--- ProcessInput Operator ------------

;Given an addition operation, populates operator with expected value

;=== Main Test ===

Test_ProcessInput_Operator
    jsr Test_ProcIn_Opr_Add
    jsr Test_ProcIn_Opr_Sub
    jsr Test_ProcIn_Opr_Mult
    jsr Test_ProcIn_Opr_Div
    rts

;=== Variants ===

Test_ProcIn_Opr_Add
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Operation_Base
    rts

;--- Data ---

.Expected   dc.b '+'
.Input      dc.b '1234+5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opr_Add',0
    ORG (*+3)&-4 ;Force Long Word alignment

;----------------
;--- Subtract ---

;Given a subtraction operation, populates operator with expected value

Test_ProcIn_Opr_Sub
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Operation_Base
    rts

;--- Data ---
.Expected   dc.b '-'
.Input      dc.b '1234-5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opr_Sub',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Subtract ---
;----------------

;----------------
;--- Multiply ---

;Given a multiplication operation, populates operator with expected value

Test_ProcIn_Opr_Mult
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Operation_Base
    rts

;--- Data ---

.Expected   dc.b '*'
.Input      dc.b '1234*5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opr_Mult',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Multiply ---
;----------------

;----------------
;--- Divide -----

;Given a division operation, populates operator with expected value

Test_ProcIn_Opr_Div
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Operation_Base
    rts

;--- Data ---

.Expected   dc.b '/'
.Input      dc.b '1234/5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opr_Div',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Divide -----
;----------------

;------------
;--- Base ---

;--- Registers ---
;   Input
;   a1 = Input
;   a2 = Expected
;   a3 = Name of test for logging

Test_ProcIn_Operation_Base
    ;Arrange
    ;Act
    jsr ProcessInput

    ;Assert
    cmp.b (a2),d7
    bne .Fail
    rts ;Success

.Fail
    move.l a3,a0
    jsr UnitTests__LogFailure
    rts ;Failure
    rts

;--- Base ---
;------------

;--- ProcessInput Operator ------------
;------------------------------------------

;=== ProcessInput =====================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~