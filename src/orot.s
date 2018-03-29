;------------------------------------
; input:
;    A - rotacja
;    ROT - globalny obrót
; ouput:
;    KX - przyrost X
;    KY - przyrost Y

.export OROT
.import ROT, KX:zeropage, KY:zeropage

.segment "CODE"
.proc OROT
    clc
    adc ROT
    and #$07
    tax
    lda TBM+2,x
    sta KX
    lda TBS+2,x
    sta KX+1
    lda TBM,x
    sta KY
    lda TBS,x
    sta KY+1
    rts
.endproc

.segment "RODATA"
TBM: .byte $FF,0,1,1,1,0,$FF,$FF,$FF,0
TBS: .byte $FF,0,0,0,0,0,$FF,$FF,$FF,0
