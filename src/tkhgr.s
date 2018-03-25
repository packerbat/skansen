;------------------------------------
; Ustawia 3 kolory, górny nibble, dolny nibble i boarder, parametry drugi i trzeci opcjonalne, jak to zrobi to przełącza VIC w tryb wysokiej rozdzielczości
; zmienia: wszystko

.export TkHGR
.import TkINK, HGR

.segment "CODE"
.proc TkHGR
    jsr TkINK
    jsr HGR
    rts
.endproc
