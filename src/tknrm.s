;------------------------------------
; Ustawia color, dwa parametry drugi opcjonalny. pierwszy parametr to kolor litery ($0286), drugi parametr to kolor tła (VIC Background Color 0)
;   a jak to zrobi to przełącza VIC na tryb tekstowy.
; zmienia: A

.export TkNRM

.segment "CODE"
.proc TkNRM
     jsr TkCOLOUR
     jsr NRM
     rts
.endproc