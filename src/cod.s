;------------------------------------
; input:
;    A, CO - aktualne położenie
; ouput:
;    CO - powiększone o A
;    A - dolne 8 bitów sumy

.export COD
.import CO:zeropage

.segment "CODE"
.proc COD
    clc
    adc CO
    sta CO
    bcc :+
    inc CO+1
:   rts         ;CO += A
.endproc
