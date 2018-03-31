;------------------------------------
; obsługa tokena FILL wypełniającego prosotokątną pamięć koloru
; o współrzednej narożnika X,Y, szerokości DX i wysokości DY
; pobiera parametry: YK, YK+1, XK, XK+1, HICOLOR
;
; input:
;
; output:
;

.export TkFILL
.import XK, YK, HICOLOR, PM:zeropage, CO:zeropage

.segment "CODE"
.proc TkFILL
    jsr $B79E       ;Evaluate Text to 1 Byte in XR. numer wiersza
    stx YK
    jsr $E200       ;Evaluate Text to 1 Byte in XR, numer kolumny
    stx YK+1
    jsr $E200       ;Evaluate Text to 1 Byte in XR, szerokosc
    dex
    stx XK
    jsr $E200       ;Evaluate Text to 1 Byte in XR, wysokosc
    stx XK+1
    jsr $0079       ;CHRGOT: Get same Byte again
    beq :++
    jsr $e200       ;Evaluate Text to 1 Byte in XR
    txa
    asl
    asl
    asl
    asl
    sta $02         ;unused zeropage byte
    ldx HICOLOR
    jsr $0079       ;CHRGOT: Get same Byte again
    beq :+
    jsr $e200       ;Get Next One Byte Parameter
:   txa
    and #$0f
    ora $02
    sta HICOLOR

:   lda #$00
    sta PM+1
    lda YK
    sta CO
    asl
    rol PM+1
    asl
    rol PM+1
    adc CO
    bcc :+
    inc PM+1
:   asl
    rol PM+1
    asl
    rol PM+1
    asl
    rol PM+1        ;PM = wiersz*40
    adc YK+1
    sta PM          ;PM = wiersz*40 + kolumna
    lda PM+1
    adc #$D0
    sta PM+1        ;PM = wiersz*40 + kolumna + $D000

    sei
    lda #$34       ;wyłącz BASIC i KERNAL
    sta $01
:   ldy XK
    lda HICOLOR
:   sta (PM),y
    dey
    bpl :-
    lda PM
    clc
    adc #$28       ;PM += 40
    sta PM
    bcc :+
    inc PM+1
:   dec XK+1
    bne :---
    lda #$37       ;włącz BASIC i KERNAL
    sta $01
    cli
    rts
.endproc

