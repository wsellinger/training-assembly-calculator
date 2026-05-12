*-----------------------------------------------------------
* Title       : UnitTests_FixedPointMultiplication
* Written by  : Bill Sellinger
* Date        : 05/12/2026
* Description : Unit Tests for Math_FixMul
*-----------------------------------------------------------

;==========================================
;=== Math_FixMul ======================

;=== Main Test ===

Test_Math_FixMul
    jsr Test_Math_FixMul_Int
    jsr Test_Math_FixMul_Mix
    jsr Test_Math_FixMul_Frac
    jsr Test_Math_FixMul_PosPos
    jsr Test_Math_FixMul_NegPos
    jsr Test_Math_FixMul_PosNeg
    jsr Test_Math_FixMul_NegNeg
    jsr Test_Math_FixMul_One
    jsr Test_Math_FixMul_Zero
    jsr Test_Math_FixMul_Exact
    jsr Test_Math_FixMul_Inexact
    jsr Test_Math_FixMul_MaxInt
    jsr Test_Math_FixMul_BothFrac
    jsr Test_Math_FixMul_NegFrac
    jsr Test_Math_FixMul_FracMix
    jsr Test_Math_FixMul_NegMix
    jsr Test_Math_FixMul_MixNeg
    jsr Test_Math_FixMul_NNMix
    rts

;=== Variants ===

;------------------------------------------
;--- Math_FixMul Integer --------------
;   3.0 x 2.0 = 6.0

Test_Math_FixMul_Int
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00030000     ;Left    3.0
    dc.l $00020000     ;Right   2.0
    dc.l $00060000     ;Result  6.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_Int',0
    ORG (*+3)&-4

;--- Math_FixMul Integer --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul Mix ------------------
;   1.5 x 2.0 = 3.0

Test_Math_FixMul_Mix
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00018000     ;Left    1.5
    dc.l $00020000     ;Right   2.0
    dc.l $00030000     ;Result  3.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_Mix',0
    ORG (*+3)&-4

;--- Math_FixMul Mix ------------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul Frac -----------------
;   0.5 x 0.5 = 0.25

Test_Math_FixMul_Frac
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00008000     ;Left    0.5
    dc.l $00008000     ;Right   0.5
    dc.l $00004000     ;Result  0.25

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_Frac',0
    ORG (*+3)&-4

;--- Math_FixMul Frac -----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul PosPos ---------------
;   +4.0 x +2.0 = +8.0

Test_Math_FixMul_PosPos
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00040000     ;Left    +4.0
    dc.l $00020000     ;Right   +2.0
    dc.l $00080000     ;Result  +8.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_PosPos',0
    ORG (*+3)&-4

;--- Math_FixMul PosPos ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul NegPos ---------------
;   -4.0 x +2.0 = -8.0

Test_Math_FixMul_NegPos
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $FFFC0000     ;Left    -4.0
    dc.l $00020000     ;Right   +2.0
    dc.l $FFF80000     ;Result  -8.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_NegPos',0
    ORG (*+3)&-4

;--- Math_FixMul NegPos ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul PosNeg ---------------
;   +4.0 x -2.0 = -8.0

Test_Math_FixMul_PosNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00040000     ;Left    +4.0
    dc.l $FFFE0000     ;Right   -2.0
    dc.l $FFF80000     ;Result  -8.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_PosNeg',0
    ORG (*+3)&-4

;--- Math_FixMul PosNeg ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul NegNeg ---------------
;   -4.0 x -2.0 = +8.0

Test_Math_FixMul_NegNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $FFFC0000     ;Left    -4.0
    dc.l $FFFE0000     ;Right   -2.0
    dc.l $00080000     ;Result  +8.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_NegNeg',0
    ORG (*+3)&-4

;--- Math_FixMul NegNeg ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul One ------------------
;   5.0 x 1.0 = 5.0

Test_Math_FixMul_One
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00050000     ;Left    5.0
    dc.l $00010000     ;Right   1.0
    dc.l $00050000     ;Result  5.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_One',0
    ORG (*+3)&-4

;--- Math_FixMul One ------------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul Zero -----------------
;   5.0 x 0.0 = 0.0

Test_Math_FixMul_Zero
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00050000     ;Left    5.0
    dc.l $00000000     ;Right   0.0
    dc.l $00000000     ;Result  0.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_Zero',0
    ORG (*+3)&-4

;--- Math_FixMul Zero -----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul Exact ----------------
;   0.25 x 0.5 = 0.125 (exact in binary)

Test_Math_FixMul_Exact
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00004000     ;Left    0.25
    dc.l $00008000     ;Right   0.5
    dc.l $00002000     ;Result  0.125

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_Exact',0
    ORG (*+3)&-4

;--- Math_FixMul Exact ----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul Inexact --------------
;   ~0.2 x 3.0 = ~0.6 (0.2 not exact in binary, truncated)

Test_Math_FixMul_Inexact
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00003333     ;Left    ~0.2  (floor of 65536/5 = 13107 = $3333)
    dc.l $00030000     ;Right   3.0
    dc.l $00009999     ;Result  ~0.6  ($3333 x 3 = $9999)

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_Inexact',0
    ORG (*+3)&-4

;--- Math_FixMul Inexact --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul MaxInt ---------------
;   32767.0 x 1.0 = 32767.0

Test_Math_FixMul_MaxInt
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $7FFF0000     ;Left    32767.0
    dc.l $00010000     ;Right   1.0
    dc.l $7FFF0000     ;Result  32767.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_MaxInt',0
    ORG (*+3)&-4

;--- Math_FixMul MaxInt ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul BothFrac -------------
;   0.5 x 2.0 = 1.0

Test_Math_FixMul_BothFrac
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00008000     ;Left    0.5
    dc.l $00020000     ;Right   2.0
    dc.l $00010000     ;Result  1.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_BothFrac',0
    ORG (*+3)&-4

;--- Math_FixMul BothFrac -------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul NegFrac --------------
;   -0.5 x 2.0 = -1.0

Test_Math_FixMul_NegFrac
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $FFFF8000     ;Left    -0.5
    dc.l $00020000     ;Right   2.0
    dc.l $FFFF0000     ;Result  -1.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_NegFrac',0
    ORG (*+3)&-4

;--- Math_FixMul NegFrac --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul FracMix --------------
;   1.5 x 1.5 = 2.25

Test_Math_FixMul_FracMix
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00018000     ;Left    1.5
    dc.l $00018000     ;Right   1.5
    dc.l $00024000     ;Result  2.25

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_FracMix',0
    ORG (*+3)&-4

;--- Math_FixMul FracMix --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul NegMix ---------------
;   -1.5 x 1.5 = -2.25
;   NOTE: Will fail until sign bug is fixed.
;   mulu treats negative integer part as unsigned in cross multiply.

Test_Math_FixMul_NegMix
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $FFFE8000     ;Left    -1.5
    dc.l $00018000     ;Right    1.5
    dc.l $FFFDC000     ;Result  -2.25

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_NegMix',0
    ORG (*+3)&-4

;--- Math_FixMul NegMix ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul MixNeg ---------------
;   1.5 x -1.5 = -2.25
;   NOTE: Will fail until sign bug is fixed.
;   mulu treats negative integer part as unsigned in cross multiply.

Test_Math_FixMul_MixNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $00018000     ;Left     1.5
    dc.l $FFFE8000     ;Right   -1.5
    dc.l $FFFDC000     ;Result  -2.25

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_MixNeg',0
    ORG (*+3)&-4

;--- Math_FixMul MixNeg ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixMul NNMix ----------------
;   -1.5 x -1.5 = 2.25
;   NOTE: Both cross-term sign errors ($80000000 each) cancel via 32-bit
;   wraparound, so this passes despite the unfixed sign bug.

Test_Math_FixMul_NNMix
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixMul_Base
    rts

.Input
    dc.l $FFFE8000     ;Left    -1.5
    dc.l $FFFE8000     ;Right   -1.5
    dc.l $00024000     ;Result   2.25

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixMul_NNMix',0
    ORG (*+3)&-4

;--- Math_FixMul NNMix ----------------
;------------------------------------------

;--- Base Tests ---------------------------

;------------------------------------------
;--- Math_FixMul Base -----------------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Pointer to 3 consecutive longs: Left, Right, Expected

Test_Math_FixMul_Base
    ;Arrange
    move.l (a6)+,d1    ;Left Factor
    move.l (a6)+,d2    ;Right Factor

    ;Act
    jsr Math_FixMul

    ;Assert
    cmp.l (a6)+,d3     ;Expected
    bne .Fail
    rts                ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts

;--- Math_FixMul Base -----------------
;------------------------------------------

;=== Math_FixMul ======================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
