;------------------------------------
; obsługa tokena UP, który przewija środek ekranu o szerokości 256 pikseli
;   UP <ilość wierszy do podniesienia>, "treść"
;
; używa $02, AD, AP, KX jako zmienne lokalne
;
; input:
;   BASIC pcode
; output:
;

.export TkUP
.import GETUP, HEX, AD:zeropage, AP:zeropage, KX:zeropage

.segment "DATA"

.segment "BSS"

.segment "CODE"
.proc TkUP
    jsr GETUP
    txa
    pha             ;nie mogę zachować X w $02 bo HEX używa $02

    lda #0
    sta $B7         ;brak parametru to parametr o zerowej długości
    jsr $0079
    beq :+
    jsr $E254       ;Get Parameters For OPEN/CLOSE, jest parametr to go pobierz do ($BB) i $B7
:   ldy #0          ;pozycja w stringu
    ldx #0          ;pozycja w $A6E0
:   jsr HEX         ;mam poprawny hex więc C=0, A=wartosc, Y-na następnym znaku, albo (C=1) nie hex więc traktuję jak zero
    bcc :+
    lda #0
    iny             ;pomijam zły znak
:   sta $A6E0,x
    inx
    cpx #32
    bne :--

    pla
    sta $02
    ldy #0

    sei
    lda #$34
    sta $01         ;BASIC, KERNAL i I/O wyłączone
    lda #$A0
    ldx #$E2
    sta AD
    stx AD+1        ;A/X adres docelowy

nastepny_wiersz:
    sta AD          ;Destination pointer
    stx AD+1
    clc
    adc #1
    sta AP          ;Source pointer AD+1
    stx AP+1
    adc #56         ;KX=AP-1+320-7
    sta KX
    bcc :+
    inx
:   inx
    stx KX+1

:   ldx #7
:   lda (AP),y
    sta (AD),y
    iny
    dex
    bne :-
    lda (KX),y      ;w tym miejscu będzie przekroczenie pamięci ekranu przy podnoszeniu wiersza 25 (bo będzie odwołanie do wiersza 26)
    sta (AD),y
    iny
    bne :--
    clc
    lda AD          ;trzeba dodać 320 czyli $140
    ldx AD+1
    adc #$40
    bcc :+
    inx
:   inx
    dec $02         ;ilość wierszy do przewinięcia
    bne nastepny_wiersz

    ldx #0
    ldy #7
    clc
:   lda $A6E0,x
    sta (AD),y
    tya
    adc #8
    tay
    inx
    cpx #32
    bcc :-

    lda #$37
    sta $01         ;BASIC, KERNAL i I/O włączone
    cli
    rts
.endproc
