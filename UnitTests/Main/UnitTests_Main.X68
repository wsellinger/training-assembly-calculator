*-----------------------------------------------------------
* Title       : UnitTests_Main
* Written by  : Bill Sellinger
* Date        : 08/01/2024
* Description : Unit Tests for Main file
*-----------------------------------------------------------

;==========================================
;=== Includes =============================
;==========================================

    INCLUDE "UnitTests/Main/UnitTests_ProcessInput.X68"
    INCLUDE "UnitTests/Main/UnitTests_PerformOperation.X68"

;==========================================
;=== Run Tests ========================

UnitTests_Main__RunTests
    jsr UnitTests_ProcessInput
    jsr UnitTests_PerformOperation
    rts

;=== Run Tests ========================
;==========================================


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~