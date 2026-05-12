*-----------------------------------------------------------
* Title       : UnitTests_FixedPointDivision
* Written by  : Bill Sellinger
* Date        : 05/08/2026
* Description : Unit Tests for Math_FixDiv
*-----------------------------------------------------------

;==========================================
;=== Math_FixDiv ======================

;=== Main Test ===

Test_Math_FixDiv
    jsr Test_Math_FixDiv_Int
    jsr Test_Math_FixDiv_Min
    jsr Test_Math_FixDiv_Mix
    jsr Test_Math_FixDiv_Frac
    jsr Test_Math_FixDiv_Rep
    jsr Test_Math_FixDiv_PosPos
    jsr Test_Math_FixDiv_NegPos
    jsr Test_Math_FixDiv_PosNeg
    jsr Test_Math_FixDiv_NegNeg
    jsr Test_Math_FixDiv_One
    jsr Test_Math_FixDiv_Self
    jsr Test_Math_FixDiv_ZeroTop
    jsr Test_Math_FixDiv_ZeroBot
    jsr Test_Math_FixDiv_Over
    jsr Test_Math_FixDiv_NotOver
    jsr Test_Math_FixDiv_Exact
    jsr Test_Math_FixDiv_Inexact
    jsr Test_Math_FixDiv_MaxTop
    jsr Test_Math_FixDiv_MaxBoth
    jsr Test_Math_FixDiv_BothFrac
    rts

;=== Variants ===

;------------------------------------------
;--- Math_FixDiv Integer --------------
;   6.0 / 3.0 = 2.0

Test_Math_FixDiv_Int
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00060000     ;Dividend  6.0
    dc.l $00030000     ;Divisor   3.0
    dc.l $00020000     ;Expected  2.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Int',0
    ORG (*+3)&-4

;--- Math_FixDiv Integer --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Min ------------------
;   Smallest meaningful values, same ratio as Int

Test_Math_FixDiv_Min
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00000006     ;Dividend  ~0.0000916
    dc.l $00000003     ;Divisor   ~0.0000458
    dc.l $00020000     ;Expected  2.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Min',0
    ORG (*+3)&-4

;--- Math_FixDiv Min ------------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Mix ------------------
;   3.0 / 2.0 = 1.5

Test_Math_FixDiv_Mix
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00030000     ;Dividend  3.0
    dc.l $00020000     ;Divisor   2.0
    dc.l $00018000     ;Expected  1.5

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Mix',0
    ORG (*+3)&-4

;--- Math_FixDiv Mix ------------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Frac -----------------
;   1.0 / 2.0 = 0.5

Test_Math_FixDiv_Frac
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00010000     ;Dividend  1.0
    dc.l $00020000     ;Divisor   2.0
    dc.l $00008000     ;Expected  0.5

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Frac',0
    ORG (*+3)&-4

;--- Math_FixDiv Frac -----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Rep ------------------
;   1.0 / 3.0 = 0.333... (repeating, truncated to 16 bits)

Test_Math_FixDiv_Rep
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00010000     ;Dividend  1.0
    dc.l $00030000     ;Divisor   3.0
    dc.l $00005555     ;Expected  ~0.3333 (floor of 65536/3 = 21845 = $5555)

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Rep',0
    ORG (*+3)&-4

;--- Math_FixDiv Rep ------------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv PosPos ---------------
;   +4.0 / +2.0 = +2.0

Test_Math_FixDiv_PosPos
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00040000     ;Dividend  +4.0
    dc.l $00020000     ;Divisor   +2.0
    dc.l $00020000     ;Expected  +2.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_PosPos',0
    ORG (*+3)&-4

;--- Math_FixDiv PosPos ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv NegPos ---------------
;   -4.0 / +2.0 = -2.0

Test_Math_FixDiv_NegPos
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $FFFC0000     ;Dividend  -4.0
    dc.l $00020000     ;Divisor   +2.0
    dc.l $FFFE0000     ;Expected  -2.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_NegPos',0
    ORG (*+3)&-4

;--- Math_FixDiv NegPos ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv PosNeg ---------------
;   +4.0 / -2.0 = -2.0

Test_Math_FixDiv_PosNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00040000     ;Dividend  +4.0
    dc.l $FFFE0000     ;Divisor   -2.0
    dc.l $FFFE0000     ;Expected  -2.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_PosNeg',0
    ORG (*+3)&-4

;--- Math_FixDiv PosNeg ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv NegNeg ---------------
;   -4.0 / -2.0 = +2.0

Test_Math_FixDiv_NegNeg
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $FFFC0000     ;Dividend  -4.0
    dc.l $FFFE0000     ;Divisor   -2.0
    dc.l $00020000     ;Expected  +2.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_NegNeg',0
    ORG (*+3)&-4

;--- Math_FixDiv NegNeg ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv One ------------------
;   5.0 / 1.0 = 5.0

Test_Math_FixDiv_One
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00050000     ;Dividend  5.0
    dc.l $00010000     ;Divisor   1.0
    dc.l $00050000     ;Expected  5.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_One',0
    ORG (*+3)&-4

;--- Math_FixDiv One ------------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Self -----------------
;   5.0 / 5.0 = 1.0

Test_Math_FixDiv_Self
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00050000     ;Dividend  5.0
    dc.l $00050000     ;Divisor   5.0
    dc.l $00010000     ;Expected  1.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Self',0
    ORG (*+3)&-4

;--- Math_FixDiv Self -----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv ZeroTop --------------
;   0.0 / 5.0 = 0.0

Test_Math_FixDiv_ZeroTop
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00000000     ;Dividend  0.0
    dc.l $00050000     ;Divisor   5.0
    dc.l $00000000     ;Expected  0.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_ZeroTop',0
    ORG (*+3)&-4

;--- Math_FixDiv ZeroTop --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv ZeroBot --------------
;   5.0 / 0.0 - returns 0.0 with C flag set to indicate error (divide by zero detected)

Test_Math_FixDiv_ZeroBot
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_CBase
    rts

.Input
    dc.l $00050000     ;Dividend  5.0
    dc.l $00000000     ;Divisor   0.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_ZeroBot',0
    ORG (*+3)&-4

;--- Math_FixDiv ZeroBot --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Over -----------------
;   4.0 / (1/16384) = 65536 - just overflows

Test_Math_FixDiv_Over
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_VBase
    rts

.Input
    dc.l $00040000     ;Dividend  4.0
    dc.l $00000004     ;Divisor   ~0.0000610 (1/16384)
                       ;Result would be 65536 - overflows

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Over',0
    ORG (*+3)&-4

;--- Math_FixDiv Over -----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv NotOver --------------
;   0.99998 / (1/65536) = 65535 - well within range

Test_Math_FixDiv_NotOver
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $7FFF0000     ;Dividend  32767.0
    dc.l $00020000     ;Divisor   2.0
    dc.l $3FFF8000     ;Expected  16383.5

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_NotOver',0
    ORG (*+3)&-4

;--- Math_FixDiv NotOver --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Exact ----------------
;   1.0 / 4.0 = 0.25 (exact in binary)

Test_Math_FixDiv_Exact
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00010000     ;Dividend  1.0
    dc.l $00040000     ;Divisor   4.0
    dc.l $00004000     ;Expected  0.25

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Exact',0
    ORG (*+3)&-4

;--- Math_FixDiv Exact ----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Inexact --------------
;   1.0 / 5.0 = 0.2 (not exact in binary, truncated)

Test_Math_FixDiv_Inexact
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00010000     ;Dividend  1.0
    dc.l $00050000     ;Divisor   5.0
    dc.l $00003333     ;Expected  ~0.2 (floor of 65536/5 = 13107 = $3333)

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_Inexact',0
    ORG (*+3)&-4

;--- Math_FixDiv Inexact --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv MaxTop ---------------
;   32767.0 / 1.0 = 32767.0

Test_Math_FixDiv_MaxTop
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $7FFF0000     ;Dividend  32767.0
    dc.l $00010000     ;Divisor   1.0
    dc.l $7FFF0000     ;Expected  32767.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_MaxTop',0
    ORG (*+3)&-4

;--- Math_FixDiv MaxTop ---------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv MaxBoth --------------
;   32767.0 / 32767.0 = 1.0

Test_Math_FixDiv_MaxBoth
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $7FFF0000     ;Dividend  32767.0
    dc.l $7FFF0000     ;Divisor   32767.0
    dc.l $00010000     ;Expected  1.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_MaxBoth',0
    ORG (*+3)&-4

;--- Math_FixDiv MaxBoth --------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv BothFrac -------------
;   0.5 / 0.25 = 2.0 (both fractional inputs, integer output)

Test_Math_FixDiv_BothFrac
    jsr UnitTests_ClearRegisters
    lea .Input,a6
    lea .Name,a5
    jsr Test_Math_FixDiv_Base
    rts

.Input
    dc.l $00008000     ;Dividend  0.5
    dc.l $00004000     ;Divisor   0.25
    dc.l $00020000     ;Expected  2.0

.Name
    dc.b 'UnitTests_MathUtils:Test_Math_FixDiv_BothFrac',0
    ORG (*+3)&-4

;--- Math_FixDiv BothFrac -------------
;------------------------------------------

;--- Base Tests ---------------------------

;------------------------------------------
;--- Math_FixDiv Base -----------------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Pointer to 3 consecutive longs: Dividend, Divisor, Expected

Test_Math_FixDiv_Base
    ;Arrange
    move.l (a6)+,d1    ;Dividend
    move.l (a6)+,d2    ;Divisor

    ;Act
    jsr Math_FixDiv

    ;Assert
    cmp.l (a6)+,d3     ;Expected
    bne .Fail
    rts                ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts

;--- Math_FixDiv Base -----------------
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Divide by Zero Base --

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Pointer to 2 consecutive longs: Dividend, Divisor
;   Pass condition: C flag set on return (divide by zero detected)

Test_Math_FixDiv_CBase
    ;Arrange
    move.l (a6)+,d1    ;Dividend
    move.l (a6)+,d2    ;Divisor

    ;Act
    jsr Math_FixDiv

    ;Assert
    bcs .Pass          ;C flag set = divide by zero detected
    bra .Fail

.Pass
    rts                ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts

;--- Math_FixDiv Divide by Zero Base --
;------------------------------------------

;------------------------------------------
;--- Math_FixDiv Overflow Base --------

;--- Registers ---
;   Input
;   a5 = Name of test for logging
;   a6 = Pointer to 2 consecutive longs: Dividend, Divisor
;   Pass condition: V flag set on return (overflow detected)

Test_Math_FixDiv_VBase
    ;Arrange
    move.l (a6)+,d1    ;Dividend
    move.l (a6)+,d2    ;Divisor

    ;Act
    jsr Math_FixDiv

    ;Assert
    bvs .Pass          ;V flag set = overflow detected
    bra .Fail

.Pass
    rts                ;Success

.Fail
    move.l a5,a0
    jsr UnitTests__LogFailure
    rts

;--- Math_FixDiv Overflow Base --------
;------------------------------------------

;=== Math_FixDiv ======================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
