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
    ldy #$3F        ;zeruje blok o wielkości 64 bajty
    lda #0
:   sta (PM),y
    dey
    bpl :-
    sty CO          ;CO = $FF

:   iny             ;Y - pozycja w stringu
:   inc CO          ;CO - pozycha w bloku pamięci
    cpy $B7
    bcs :+
    lda ($BB),y
    cmp #'*'
    beq :--         ;'*' oznacz pozostaw bez zmian czyli zero
    jsr HEX
    sty CO+1        ;przechowaj pozycja litery
    ldy CO
    sta (PM),y
    ldy CO+1        ;przywróć pozycję litery
    bne :-          ;ten skok jest bezwarunkowy a Y już wskazuje na następną literę

:   lda #$37        ;przywracam oba ROM-y
    sta $01
    cli
    rts

E82:
    jmp $B248
.endproc

