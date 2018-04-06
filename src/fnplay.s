;------------------------------------
; obsługa funkcji PLAY(g)
;
; używa $02FF
;
; input:
;
; output:
;

.export FnPLAY
.import VGT

.segment "CODE"
.proc FnPLAY
    jsr $AEF1       ;Expression in Brackets
    jsr $AD8D       ;Confirm Result
    jsr $B7A1       ;Evaluate Text to 1 Byte in XR
    dex
    txa             ;parametr-1
    cmp #3
    bcs :++
    sta $02FF          ;jest 0-2 więc mnożę przez 7
    asl $02FF
    adc $02FF
    asl $02FF
    adc $02FF
    tax             ;numer struktury dla generatora 0,7,14
    lda VGT,x
    beq :+
    lda #255        ;zwraca 0 gdy VGT jest 0 albo 255 gdy VGT nie jest 0
:   jmp $BC3C       ;Convert A to float

:   jmp $B248       ;jest 3-255 więc ?ILLEGAL QUANTITY
.endproc

