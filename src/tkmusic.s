;------------------------------------
; obsługa tokena MUSIC wypełniającego prosotokątną pamięć koloru
; o współrzednej narożnika X,Y, szerokości DX i wysokości DY
; pobiera parametry: YK, YK+1, XK, XK+1, HICOLOR
;
; używa $02
;
; input:
;
; output:
;

.export TkMUSIC
.import GETN, PM:zeropage, DY:zeropage, KY:zeropage, AP:zeropage

.segment "CODE"
.proc TkMUSIC
    jsr $E209       ;Check Default Parameters
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    and #$0F
    beq E40         ;nie może być 0, ma być 1-15
    pha
    jsr $E206       ;Check Default Parameters
    jsr $E254       ;Get Parameters For OPEN/CLOSE, używa PM
    pla
    clc
    adc #$B0
    sta PM+1
    lda #0
    tay
    sta PM          ;Adres jest $B100, $B200, ... $BF00     (czyli po 256 bajtów na każdy głos)
    sta DY
:   jsr GETN
    sty KY
    ldy DY
    lda AP
    sta (PM),y
    iny
    lda AP+1
    sta (PM),y
    iny
    beq E39
    sty DY
    ldy KY
    cpy $B7
    bcc :-

    ldy DY
    lda #0
    sta (PM),y
    iny
    sta (PM),y      ;dwa zera kończą utwór
    rts

E39:
    jmp $B97e       ;Output ?OVERFLOW Error

E40:
    jmp $B248       ;?ILLEGAL QUANTITY

.endproc
