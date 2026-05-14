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
    jsr Test_ProcessInput_Error
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
    jsr Test_ProcIn_Opd_L_Max
    jsr Test_ProcIn_Opd_L_Min
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
.Input      dc.b '1234+5678',0
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
.Input      dc.b ' 1234 + 5678 ',0
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
.Input      dc.b '12.34 + 5678',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_L_Dec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Decimal ---
;---------------

;-----------
;--- Max ---

;Maximum positive value: 32767.65535 -> $7FFFFFFF

Test_ProcIn_Opd_L_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Left_Base
    rts

;--- Data ---

.Expected   dc.l $7FFFFFF9
.Input      dc.b '32767.9999+0',0 ;Max value with 4 decimal places (32767.9999) -> $7FFFFFF9
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_L_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Max ---
;-----------

;-----------
;--- Min ---

;Minimum negative value: -32768 -> $80000000

Test_ProcIn_Opd_L_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Left_Base
    rts

;--- Data ---

.Expected   dc.l $80000000
.Input      dc.b '-32768+0',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_L_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Min ---
;-----------

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
    jsr Test_ProcIn_Opd_R_Max
    jsr Test_ProcIn_Opd_R_Min
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
.Input      dc.b '1234 + 56.78',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_R_Dec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Decimal ---
;---------------

;-----------
;--- Max ---

;Maximum positive value: 32767.65535 -> $7FFFFFFF

Test_ProcIn_Opd_R_Max
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Right_Base
    rts

;--- Data ---

.Expected   dc.l $7FFFFFF9
.Input      dc.b '0+32767.9999',0 ;Max value with 4 decimal places (32767.9999) -> $7FFFFFF9
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_R_Max',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Max ---
;-----------

;-----------
;--- Min ---

;Minimum negative value: -32768 -> $80000000

Test_ProcIn_Opd_R_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Expected,a2
    lea .Name,a3
    jsr Test_ProcIn_Opd_Right_Base
    rts

;--- Data ---

.Expected   dc.l $80000000
.Input      dc.b '0+-32768',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Opd_R_Min',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Min ---
;-----------

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

;------------------------------------------
;--- ProcessInput Error ---------------

;Given invalid input, verifies Set_False is returned

;=== Main Test ===

Test_ProcessInput_Error
    jsr Test_ProcIn_Err_BadChar
    jsr Test_ProcIn_Err_OneDec
    jsr Test_ProcIn_Err_OneOp
    jsr Test_ProcIn_Err_OvrInt
    jsr Test_ProcIn_Err_OvrFrac
    jsr Test_ProcIn_Err_OvrNeg
    jsr Test_ProcIn_Err_NoOp
    jsr Test_ProcIn_Err_NoLeft
    jsr Test_ProcIn_Err_NoRight
    rts

;=== Variants ===

;--------------------
;--- Bad Char -------

;Invalid character in operand

Test_ProcIn_Err_BadChar
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '1a2+3',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_BadChar',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Bad Char -------
;--------------------

;--------------------
;--- One Decimal ----

;Two decimal points in one operand

Test_ProcIn_Err_OneDec
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '1.2.3+4',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_OneDec',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- One Decimal ----
;--------------------

;--------------------
;--- One Operator ---

;Two operators in expression

Test_ProcIn_Err_OneOp
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '1++2',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_OneOp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- One Operator ---
;--------------------

;--------------------
;--- Ovr Int --------

;Positive integer exceeds max (32768 > 32767)

Test_ProcIn_Err_OvrInt
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '32768+0',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_OvrInt',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Ovr Int --------
;--------------------

;--------------------
;--- Ovr Frac -------

;Fractional digit string exceeds $FFFF (99999 > 65535)

Test_ProcIn_Err_OvrFrac
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '1.100000+0',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_OvrFrac',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Ovr Frac -------
;--------------------

;--------------------
;--- Ovr Neg --------

;-32768 with fractional exceeds min (-32768.65535 combined > $80000000)

Test_ProcIn_Err_OvrNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '-32768.00002+0',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_OvrNeg',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Ovr Neg --------
;--------------------

;--------------------
;--- No Operator ----

;Expression with no operator - only a single number

Test_ProcIn_Err_NoOp
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '1234',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_NoOp',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- No Operator ----
;--------------------

;----------------------
;--- No Left Operand ---

;Operator present but no left operand digits precede it

Test_ProcIn_Err_NoLeft
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '+42',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_NoLeft',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- No Left Operand ---
;----------------------

;-----------------------
;--- No Right Operand ---

;Operator present but no right operand digits follow it

Test_ProcIn_Err_NoRight
    jsr UnitTests_ClearRegisters
    lea .Input,a1
    lea .Name,a3
    jsr Test_ProcIn_Err_Base
    rts

;--- Data ---

.Input      dc.b '42+',0
.Name       dc.b 'UnitTests_ProcessInput:Test_ProcIn_Err_NoRight',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- No Right Operand ---
;-----------------------

;--- ProcessInput Error ---------------
;------------------------------------------

;------------------------------------------
;--- ProcessInput Error Base ----------

;Verifies ProcessInput returns Set_False (Z=0) for error cases
;
;--- Registers ---
;   Input
;   a1 = Input string
;   a3 = Name of test for logging

Test_ProcIn_Err_Base
    ;Act
    jsr ProcessInput

    ;Assert - expect Set_False (Z=0), fail if Set_True (Z=1)
    beq .Fail
    rts

.Fail
    move.l a3,a0
    jsr UnitTests__LogFailure
    rts

;--- ProcessInput Error Base ----------
;------------------------------------------

;=== ProcessInput =====================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~