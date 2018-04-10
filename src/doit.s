;------------------------------------
; procedura DOIT -
; zmienia: wszystko
; nie sprawdzam górnego zakresu tokena, to żle

.export DOIT
.export TOKVEC
.import TkPAUSE, TkCOLOUR, TkHGR, TkCLS, TkINK, TkNRM, TkVOLUME, TkBASIC, TkTEXT, TkPLOT
.import TkLINE, TkDRAW, TkFILL, TkMUSIC, TkPLAY, TkVOICE, TkSCROLL, TkSHAPE, TkPATH, TkSPRITE
.import TkMOVE, TkSEI, TkCLI, TkUP, TkSHIFT

.segment "CODE"
.proc DOIT
    jsr $0073   ;CHRGET: Get next Byte of BASIC Text
    jsr DOIT1
    jmp $A7AE   ;BASIC Warm Start
.endproc

.proc DOIT1
    beq KONIEC
    php
    cmp #$8c
    beq :++
    cmp #$cd
    bcc :+          ;$01..$CC - nie moje
    cmp #$e6
    bcs :+          ;$e6..$ff - nie moje

    plp
    sec
    sbc #$cd
    asl
    tay
    lda TOKVEC+1,y
    pha
    lda TOKVEC,y
    pha
    jmp $0073   ;CHRGET: Get next Byte of BASIC Text
    
:   plp
    jmp $A7EF   ;Perform BASIC Keyword

:   plp         ;moja obsługa RESTORE
    jsr $0073   ;next byte
    beq :+      ;bez parametru
    jsr $AD8A      ;Confirm result
    jsr $B7F7      ;Convert FAC#1 to Integer to $14/$15
    jsr $A613      ;Search for line number
    lda $5F
    ldy $60
    sec
    sbc #$01
    jmp $A824      ;RESTORE Read to specific line number
:   jmp $A81D      ;original Perform [restore]

KONIEC:
    rts         ;skok do wykonania mojego tokena, akumulator ma następny znak programu
.endproc

.segment "RODATA"
TOKVEC: .word TkUP-1, TkPAUSE-1, TkCOLOUR-1, TkHGR-1, TkCLS-1, TkINK-1, TkNRM-1, TkPLOT-1, TkLINE-1, TkDRAW-1
        .word TkSHIFT-1, TkMOVE-1, TkMUSIC-1, TkVOICE-1, TkVOLUME-1, TkCLI-1, TkSHAPE-1, TkPATH-1, TkSEI-1, TkBASIC-1
        .word TkFILL-1, TkTEXT-1, TkSPRITE-1, TkSCROLL-1, TkPLAY-1

