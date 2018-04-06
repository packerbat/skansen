;------------------------------------
; Pobiera opcjonalny parametr PTYP
; input:
;
; output:
;    PTYP - zmieniony jeśli wystąpił

.export GETA, PTYP

.segment "DATA"
PTYP:    .byte 1

.segment "CODE"
.proc GETA
    jsr $E206   ;Get Next One Byte Parameter
    jsr $E200   ;Check Default Parameters
    stx PTYP
    rts
.endproc

