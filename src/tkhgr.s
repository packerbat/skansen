;------------------------------------
; Ustawia 3 kolory, górny nibble, dolny nibble i boarder, parametry drugi i trzeci opcjonalne, jak to zrobi to przełącza VIC w tryb wysokiej rozdzielczości
; zmienia: wszystko

.export TkHGR, XC, YC
.import TkINK, HGR

.segment "DATA"
YC:   .word 0           ;ostatni narysowany punkt, używa DRAW, LINE, LETT, POT
XC:   .word 0

.segment "CODE"
.proc TkHGR
    jsr TkINK
    jsr HGR
    rts
.endproc
