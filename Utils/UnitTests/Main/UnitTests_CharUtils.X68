*-----------------------------------------------------------
* Title       : UnitTests_CharUtils
* Written by  : Bill Sellinger
* Date        : 07/31/2024
* Description : Unit Tests for CharUtils
*-----------------------------------------------------------

;==========================================
;=== Run Tests ========================

UnitTests_Char__RunTests
    jsr Test_IsNumByte_True
    jsr Test_IsNumByte_False
    jsr Test_Char_IsInList_True
    jsr Test_Char_IsInList_False
    jsr Test_Char_IsInList_Invalid
    rts

;=== Run Tests ========================
;==========================================

;==========================================
;=== Char_IsNumeric ===================

;------------------------------------------
;--- Char_IsNumeric True --------------

;Given Number Sets CCR Z Flag to True

Test_IsNumByte_True
    move.b #'0',d0
    jsr Char_IsNumeric
    bne .Fail    
    rts ;Success

.Fail
    lea .Name,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;=== Data ===
.Name
    dc.b 'UnitTests_CharUtils:Test_IsNumByte_True',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Char_IsNumeric True --------------
;------------------------------------------

;------------------------------------------
;--- Char_IsNumeric False -------------

;Given Non-number, Sets CCR Z Flag to False

Test_IsNumByte_False
    move.b #'a',d0
    jsr Char_IsNumeric
    beq .Fail
    rts ;Success

.Fail
    lea .Name,a0
    jsr UnitTests__LogFailure
    rts ;Failure

;=== Data ===
.Name
    dc.b 'UnitTests_CharUtils:Test_IsNumByte_False',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Char_IsNumeric False -------------
;------------------------------------------

;=== Char_IsNumeric ===================
;==========================================

;==========================================
;=== Char_IsInList ====================

;------------------------------------------
;--- Char_IsInList True ---------------

;Given Value with Match in List, Sets CCR Z Flag to True

Test_Char_IsInList_True
    move.b #'a',d0
    lea .Data,a0
    jsr Char_IsInList
    bne .Fail
    rts ;Success

.Fail
    lea .Name,a0
    jsr UnitTests__LogFailure
    rts ;Failure
    
;=== Data ===
.Data 
    dc.b 'chars',0
.Name
    dc.b 'UnitTests_CharUtils:Test_Char_IsInList_True',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Char_IsInList True ---------------
;------------------------------------------

;------------------------------------------
;--- Char_IsInList False---------------

;Given Value with No Match in List, Sets CCR Z Flag to False

Test_Char_IsInList_False
    move.b #'a',d0
    lea .Data,a0
    jsr Char_IsInList
    beq .Fail
    rts ;Success

.Fail
    lea .Name,a0
    jsr UnitTests__LogFailure
    rts ;Failure
    
;=== Data ===
.Data 
    dc.b 'CHARS',0
.Name
    dc.b 'UnitTests_CharUtils:Test_Char_IsInList_False',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Char_IsInList False---------------
;------------------------------------------

;------------------------------------------
;--- Char_IsInList Invalid Input -------

;Given Null with Null in List, Sets CCR Z Flag to False

Test_Char_IsInList_Invalid
    move.b #0,d0
    lea .Data,a0
    jsr Char_IsInList
    beq .Fail
    rts ;Success

.Fail
    lea .Name,a0
    jsr UnitTests__LogFailure
    rts ;Failure
    
;=== Data ===
.Data 
    dc.b 0
.Name
    dc.b 'UnitTests_CharUtils:Test_Char_IsInList_Invalid',0
    ORG (*+3)&-4 ;Force Long Word alignment

;--- Char_IsInList False---------------
;------------------------------------------

;=== Char_IsInList ====================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
