;------------------------------------
; procedura FnSCROLL - chyba ta funkcja nie została zaimplementowana
; zmienia: wszystko

.export FnSCROLL
.import NGAT

.segment "CODE"
.proc FnSCROLL
    lda NGAT
    beq :+
    lda #$ff
:   jsr $BC3C       ;convert A to FCC#1
    rts
.endproc
