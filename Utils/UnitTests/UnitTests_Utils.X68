*-----------------------------------------------------------
* Title       : UnitTests_Utils
* Written by  : Bill Sellinger
* Date        : 07/31/2024
* Description : Main Entrypoint for all Utils Unit Tests
*-----------------------------------------------------------

;==========================================
;=== Includes =============================
;==========================================

    INCLUDE "Utils/UnitTests/Main/UnitTests_CharUtils.X68"
    INCLUDE "Utils/UnitTests/Main/UnitTests_MathUtils.X68"

;==========================================
;=== Run Tests ========================

UnitTests_Utils__RunTests
    jsr UnitTests_Char__RunTests
    jsr UnitTests_Math__RunTests
    rts

;=== Run Tests ========================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
