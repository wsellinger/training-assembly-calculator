*-----------------------------------------------------------
* Title      : FixedPoint
* Written by :
* Date       :
* Description:
* In this exercise, Write an Easy68k assembly program that performs fixed-point addition, subtraction,
* multiplication, and division. Assume a fixed-point format with 16 bits for the integer part and 16 bits 
* for the fractional part. The program should take two decimal numbers as input and output a decimal number.
* The program should be able to handle input that is out of the expected bounds by telling the user that it
* is invalid input.

* Tell me what is the minimum and maximum value you can represent?
*-----------------------------------------------------------

    ORG $10
    INCLUDE "UnitTests/UnitTests.X68"
    INCLUDE "Main/Main.X68"
    ORG (*+3)&-4 ;Force Long Word alignment

START:
    ;Run Tests
    jsr UnitTests__RunTests
    
    ;Run Program
    jsr MAIN    

    ;Halt Program
    SIMHALT
    END START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
