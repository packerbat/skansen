;------------------------------------
; procedura DOIT -
; zmienia: wszystko
; nie sprawdzam górnego zakresu tokena, to żle

.export DOIT
.export TOKVEC
.import TkPAUSE, TkCOLOUR, TkHGR, TkCLS, TkINK, TkNRM, TkVOLUME, TkBASIC, TkTEXT, TkPLOT

.segment "CODE"
.proc DOIT
    jsr $0073   ;CHRGET: Get next Byte of BASIC Text
    jsr DOIT1
    jsr $A7AE   ;BASIC Warm Start
    rts
.endproc

.proc DOIT1
    beq KONIEC
    sbc #$80       ;skąd wiem, że C=1?
    bcc :+
    cmp #$23
    bcc :++
    cmp #$4D
    bcc :+++
    sbc #$4D
    asl
    tay
    lda TOKVEC+1,y
    pha
    lda TOKVEC,y
    pha
    jmp $0073   ;CHRGET: Get next Byte of BASIC Text
:   jmp $A804   ;Perform [let], bo znak był poniżej $80
:   jmp $A7F7   ;Perform BASIC Keyword, bo znak był poniżej $80+$23
:   jmp $A80E   ;Perform GOTO or SYNTAC ERROR, bo znak był poniżej $80+$4D, moje zaczynają się od $80+$4D, chyba $80+$4C jest niewykorzystany
KONIEC:
    rts         ;skok do wykonania mojego tokena, akumulator ma następny znak programu
.endproc

.segment "RODATA"
TK1 = 1
TK2 = 2
TK9 = 9
TK10 = 10
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
TOKVEC: .word TK1-1, TkPAUSE-1, TkCOLOUR-1, TkHGR-1, TkCLS-1, TkINK-1, TkNRM-1, TkPLOT-1, TK9-1, TK10-1, TK11-1, TK12-1, TK13-1, TK14-1, TkVOLUME-1, TK16-1, TK17-1, TK18-1, TK19-1, TkBASIC-1, TkTEXT-1, TK21-1, TK22-1, TK23-1

