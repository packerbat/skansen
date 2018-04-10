;------------------------------------
; obsługa funkcji SPRITE(s)
;
; używa $02FF
;
; input:
;
; output:
;

.export FnSPRITE
.import MGT

.segment "CODE"
.proc FnSPRITE
    jsr $AEF1       ;Expression in Brackets
    jsr $AD8D       ;Confirm Result
    jsr $B7A1       ;Evaluate Text to 1 Byte in XR
    txa             ;parametr-1
    and #$0F        ;dlaczego 16 spritów a nie 8 spritów
    tax             ;numer sprita
    lda MGT,x
    beq :+
    lda #255        ;zwraca 0 gdy MGT jest 0 albo -1 gdy MGT nie jest 0
:   jmp $BC3C       ;Convert A to float
.endproc

