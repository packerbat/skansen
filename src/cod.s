;------------------------------------
; input:
;    A, CO - aktualne położenie
; ouput:
;    CO - powiększone o A
;    A - dolne 8 bitów sumy

.export COD, CO

.segment "UTIL": zeropage
CO:   .res 2

.segment "CODE"
.proc COD
    clc
    adc CO
    sta CO
    bcc :+
    inc CO+1
:   rts         ;CO += A
.endproc
