;------------------------------------
; obsługa tokena TkSHAPE definiującego sprite
; jest to rodzaj kompilatora, który zamienia ciąg liczb HEX
; albo gwiazdek, które zastępują "*"
; na blok pamięci w obszarze $D400-$DFFF, bloków może być 48
;
; używa PM, CO - oba całkowcie lokalnie
;
; input:
;   A - byte to tokenie SHAPE
;   Z - 1=koniec
; output:
;

.export TkSHAPE
.import HEX, CO:zeropage, PM:zeropage

.segment "CODE"
.proc TkSHAPE
    jsr $E211
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    cpx #$30        ;48 bloków pamięci po 64 bajty
    bcs E82
    txa
    pha
    jsr $E254       ;Get Parameters For OPEN/CLOSE, używa PM
    lda #0
    sta PM
    pla
    lsr
    ror PM
    lsr
    ror PM          ;parametr przez 4 a PM jest 2 dolne bity * 64 = xx000000, A jest 0..11
    adc #$D4        ;$D400-$DFFF - to jest bank spritów
    sta PM+1

    sei
    lda #$34        ;wyłączam KERNEL i BASIC (całą pamięć)
    sta $01

    ldy #0
    sty CO          ;Y =0, CO = 0
    ldx #64         ;długość sprita, pętla po X
:   jsr HEX         ;mam poprawny hex więc C=0, A=wartosc, Y-na następnym znaku, albo (C=1) nie hex więc traktuję jak zero
    bcc :+
    lda #0
    iny             ;pomijam zły znak
:   sty CO+1        ;przechowaj pozycja litery
    ldy CO
    sta (PM),y
    inc CO
    ldy CO+1        ;Y-litera w stringu
    dex
    bne :--         ;ten skok jest bezwarunkowy a Y już wskazuje na następną literę

    lda #$37        ;przywracam oba ROM-y
    sta $01
    cli
    rts

E82:
    jmp $B248
.endproc

