;------------------------------------
; coś oblicza
; 

.export NUM
.import DX: zeropage

.segment "CODE"
.proc NUM
    lda #$00
    sta DX
:   jsr GETL
    bcs :+
    pha
    lda DX
    asl
    asl
    clc
    adc DX
    asl
    sta DX
    clc
    pla
    adc DX
    sta DX
    jmp :-
:   rts
.endproc
