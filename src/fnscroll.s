;------------------------------------
; procedura FnSCROLL - chyba ta funkcja nie została zaimplementowana
; zmienia: wszystko

.export FnSCROLL

.segment "CODE"
.proc FnSCROLL
    lda NGAT
    beq :+
    lda #$ff
:   jsr $BC3C       ;Evaluate <sgn>, to jest jakaś pomyłka
    rts
.endproc

.segment "BSS"
NGAT:   .res 1