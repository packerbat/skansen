;------------------------------------
; obsługa tokena SPRITE
;   SPRITE ON "011**100" - '0' wyłącza, '1' włącza, '*' nie zmiena stanu sprita o danym numerze
;   SPRITE <nr>,@x,y,<nr bloku>,<kolor>,<expand xy>,<priority>
; używa $02, $D7, CO jako zmienne lokalne
;
; input:
;   BASIC pcode
; output:
;

.export TkSPRITE
.import GETSP, SXY, TBP, CO:zeropage

.segment "CODE"
.proc TkSPRITE
    cmp #$91        ;token ON
    bne nie_ma_ON
    jsr $0073
    jsr $E257       ;Get Parameters For OPEN/CLOSE
    ldy #$FF
:   iny             ;y to numer sprita i jednocześnie numer litery w stringu, nie sprawdzam długości stringa, to błąd
    cpy $B7
    bcs koniec_SPRITE
    lda ($BB),y
    cmp #'*'
    beq :-          ;'*' oznacza nie ruszaj tego sprita
    and #1          ;liczy się tylko najmłoszy bit, watość nie jest istotna
    sta $02         ;przechowaj
    lda TBP,y       ;tablica potęg dwójki
    ora $D015       ;Sprite display Enable, A=$D015 z wyjątkiem sprita o numerze Y, który ma 1
    ldx $02
    bne :+
    eor TBP,y       ;trzeba zgasić ten bit
:   sta $D015
    jmp :--

koniec_SPRITE:
    rts

nie_ma_ON:
    jsr $E211       ;Check Default Parameters
    jsr GETSP       ;ustawia $D7 na numer sprita a $02 ma bit tego sprita
    jsr SXY             ;albo weź liczbę albo weź współrzędne po '@' i już tu nie wracaj
    beq koniec_SPRITE
    cpx #$30            ;jeden z 48 banków pamięci po 64 bajty
    bcs zla_wartosc

    php
    sei
    lda #$34
    sta $01
    txa
    clc
    adc #$50
    ldx $D7
    sta $D3F8,x     ;coś sobie zapimiętuje poniżej 48 banków pamięci
    lda #$37
    sta $01
    plp             ;odblokowuje przerwania jeśli były poprzednio odblokowane

    jsr SXY             ;albo weź liczbę albo weź współrzędne po '@' i już tu nie wracaj
    beq koniec_SPRITE
    txa
    ldx $D7
    and #$0F
    sta $D027,x         ;Sprite n-th Color
    jsr SXY             ;albo weź liczbę albo weź współrzędne po '@' i już tu nie wracaj
    beq koniec_SPRITE
    txa
    and #3
    sta CO
    lda $02
    ora $D01D       ;Sprites Expand 2x Horizontal (X)
    lsr CO
    bcs :+
    eor $02
:   sta $D01D       ;Sprites Expand 2x Horizontal (X)
    lda $02
    ora $D017       ;Sprites Expand 2x Vertical (Y)
    lsr CO
    bcs :+
    eor $02
    sta $D017       ;Sprites Expand 2x Vertical (Y)

    jsr SXY             ;albo weź liczbę albo weź współrzędne po '@' i już tu nie wracaj
    beq koniec_SPRITE
    txa
    and #1
    sta CO
    lda $02
    ora $D01B       ;Sprite to Background Display Priority
    lsr CO
    bcc :+
    eor $02
:   sta $D01B       ;Sprite to Background Display Priority

    jsr SXY         ;albo weź liczbę albo weź współrzędne po '@' i już tu nie wracaj
    rts

zla_wartosc:
    jmp $B248
.endproc
