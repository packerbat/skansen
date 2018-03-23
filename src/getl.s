;------------------------------------
; coś oblicza
; 

.export GETL
.import DX: zeropage

.segment "CODE"
.proc GETL
    iny
    cpy $B7     ;Number of Characters in Filename
    bcs :+
    sec
    sbc #$30
    cmp #$d0
:   rts
.endproc
