;------------------------------------
; obsługa tokena PLAY [CONT] track1[, trakc2[, track3]]
;
; używa $D7
;
; input:
;
; output:
;

.export TkPLAY
.import WOL, AN, VGT, WY, VOC

.segment "CODE"
.proc TkPLAY
    beq koniec_PLAY
    ldx #$00
    stx WOL
    cmp #$9A        ;token CONT
    bne :+
    jsr $0073
    ldx #$80
    stx WOL
:   jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    ora WOL
    sta WOL
    lda #$0F
    sta $D418       ;Master Volume na maksa
    lda #$00
    php
    sei
:   sta $D7
    jsr $0079
    beq E50
    jsr $E200       ;Get Next One Byte Parameter ta procedura przerywa TkPLAY więc chyba źle
    txa
    ldx $D7
    and #$0F
    beq E78
    clc
    adc #$B0
    sta AN+1,x
    lda WOL
    sta VGT,x
    lda #$00
    sta AN,x
    sta WY,x
    sta WY+1,x
    lda VOC,x
    and #$FE
    sta VOC,x
E78:
    txa
    clc
    adc #$07
    cmp #21
    bcc :-
E50:
    plp
koniec_PLAY:
    rts
.endproc

