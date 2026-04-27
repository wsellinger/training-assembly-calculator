*-----------------------------------------------------------
* Title       : GeneralUtils
* Written by  : Bill Sellinger
* Date        : 08/07/2024
* Description : General tools and utilities
*-----------------------------------------------------------

;==========================================
;=== Constants ============================
;==========================================

CCR_All equ %11111111
CCR_Zero equ %00000100

ByteAsBits equ 8
LongAsBytes equ 4

;==========================================
;=== Set True ======================

;Sets the CCR Zero Flag to True for easy boolean conditionals

Set_True
    or #CCR_Zero,ccr
    rts

;=== Set True ======================
;==========================================

;==========================================
;=== Set False ========================

;Sets the CCR Zero Flag to False for easy boolean conditionals

Set_False
    and #CCR_All-CCR_Zero,ccr
    rts

;=== Set False ========================
;==========================================

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
