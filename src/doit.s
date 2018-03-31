;------------------------------------
; procedura DOIT -
; zmienia: wszystko
; nie sprawdzam górnego zakresu tokena, to żle

.export DOIT
.export TOKVEC
.import TkPAUSE, TkCOLOUR, TkHGR, TkCLS, TkINK, TkNRM, TkVOLUME, TkBASIC, TkTEXT, TkPLOT, TkLINE, TkDRAW, TkFILL

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
    cmp #$e5
    bcs :+          ;$e5..$ff - nie moje

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
TK1 = 1
TK2 = 2
TK11 = 11
TK12 = 12
TK13 = 13
TK14 = 14
TK16 = 16
TK17 = 17
TK18 = 18
TK19 = 19
TK21 = 21
TK22 = 22
TK23 = 23
TOKVEC: .word TK1-1, TkPAUSE-1, TkCOLOUR-1, TkHGR-1, TkCLS-1, TkINK-1, TkNRM-1, TkPLOT-1, TkLINE-1, TkDRAW-1, TK11-1, TK12-1, TK13-1, TK14-1, TkVOLUME-1, TK16-1, TK17-1, TK18-1, TK19-1, TkBASIC-1, TkFILL-1, TkTEXT-1, TK21-1, TK22-1, TK23-1

