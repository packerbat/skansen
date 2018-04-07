;------------------------------------
; Pobiera parametry dla SCROLL [CONT] "text"[, SSX=1[, SODX=1[, WOL=1]]]
;
; input:
;
; output:
;

.export GETS, CONT, SODS, SSX
.import WOL

.segment "DATA"
CONT:  .byte 1
SODS:  .byte 1
SSX:   .byte 1,0     ;skala napisu i licznik powtórzeń tej samej kolumny

.segment "CODE"
.proc GETS
    ldx #1
    stx CONT
    stx SODS
    stx SSX
    cmp #$9A    ;token CONT
    bne :+
    jsr $0073
    ldx #$81
:   stx WOL
    jsr $E257       ;Get Parameters For OPEN/CLOSE
    jsr $E206       ;Check Default Parameters
    jsr $E200
    stx SSX
    jsr $E206       ;Check Default Parameters
    jsr $E200
    stx SODS
    jsr $E206       ;Check Default Parameters
    jsr $E200
    lda WOL
    and #$80
    sta WOL
    txa
    ora WOL
    sta WOL
    rts
.endproc
