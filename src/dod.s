;------------------------------------
; input:
;    XC, YC - aktualne położenie
; ouput:
;    XC, YC - nowe położenie

.export DOD
.import KX:zeropage, KY:zeropage, XC, YC

.segment "CODE"
.proc DOD
    lda XC
    clc
    adc KX
    sta XC
    lda XC+1
    adc KX+1
    sta XC+1    ;XC += KX
    lda YC
    clc
    adc KY
    sta YC
    lda YC+1
    adc KY+1
    sta YC+1    ;YC += KY
    rts
.endproc
