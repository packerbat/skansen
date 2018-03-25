;------------------------------------
; obsługa tokena TEXT rysującego tekst na ekreanie
; pobiera parametry: opcjoanlne współrzędne XC, YC (jeśli jest znak '@'),
;   treść, opcjonalne parametry SX=1, ODS=1, WOL=0, PTYP
; Używa dolny bajt KY do przechowywania numeru wyświetlanej litery
; WOL = to odstęp czasu między drukowaniem poszczególnych liter.
;
; input:
;
; output:
;    C - zawsze 1

.export TkTEXT, KY
.import LETT, GETT

.segment "CODE"
.proc TkTEXT
    jsr GETT
    ldy #$00
    cli
:   sty KY
    lda ($BB),y     ;Pointer: Current File name Address
    jsr LETT
    ldy KY
    iny
    cpy $B7         ;Number of Characters in Filename
    bcc :-
    rts
.endproc

.segment "FPAC2": zeropage
KY:   .res 2
