;------------------------------------
; obsługa tokena DRAW rysującego tekst na ekreanie
; pobiera parametry: opcjoanlne współrzędne XC, YC (jeśli jest znak '@'),
;   treść, opcjonalne parametry SX=1, ODS=1, WOL=0, PTYP
; Używa dolny bajt KY do przechowywania numeru wyświetlanej litery
; WOL = to odstęp czasu między drukowaniem poszczególnych liter.
;
; Używa $02
;
; input:
;
; output:
;    C - zawsze 1

.export TkDRAW, ROT
.import GETD, POT, NUM, DOD, CZEK, OROT, DX:zeropage, DY:zeropage

.segment "CODE"
.proc TkDRAW
    jsr GETD
    jsr POT
    ldy #$00
    cli
:   lda ($BB),y     ;Pointer: Current File name Address
    sta $02
    jsr OROT
    jsr NUM
    lda DX
    bne :+
    inc DX
:   sty DY
:   jsr DOD
    jsr CZEK
    lda $02
    bmi :+
    jsr POT
:   dec DX
    bne :--
    ldy DY
    cpy $B7         ;Number of Characters in Filename
    bcc :----
    rts
.endproc

.segment "BSS"
ROT: .res 1
