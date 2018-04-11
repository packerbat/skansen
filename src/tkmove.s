;------------------------------------
; obsługa tokena MOVE
;   MOVE [CONT] <nr>, <path>, <rot>, <speed> @x,y
;   MOVE STOP <nr>,<nr>,...
;
; W oryginale było blokowanie przerwań w trakcie wypełniania struktury sprita
;
; używa WOL, $02, $D7 jako zmienne lokalne
;
; input:
;   BASIC pcode
; output:
;

.export TkMOVE, MWO, MGT, MPO, MRO, MWC, MIK
.import WOL, GETSP, SXY, TBP

.segment "DATA"
MWO:    .byte 0,0,0,0,0,0,0,0

.segment "BSS"
MGT:   .res 8           ;numer ścieżki 0-7
MPO:   .res 8           ;domyślnie 0, wskaźnik wewnątrz ścieżki
MRO:   .res 8           ;domyślnie 0, globalna rotacja kierunku sprita
MWC:   .res 8           ;domyślnie 1
MIK:   .res 8           ;domyślnie 1, licznik kroków w danym kierunku

.segment "CODE"
.proc TkMOVE
    cmp #$90        ;token STOP
    beq move_stop
    ldx #1
    stx WOL
    cmp #$9A        ;token CONT
    bne :+
    jsr $0073
    ldx #$81
    stx WOL
:   jsr $E211       ;Output ?SYNTAX Error if no more text
    jsr GETSP       ;$D7=numer sprita, $02 bit sprita
    jsr $E20E       ;Output ?SYNTAX Error if no comma or no more text after comma
    jsr $B79E       ;Evaluate Text to 1 Byte in XR, adres jednego z 8 bloków o długości 256 bajtów w obszarze $A800-$AFFF, Y=0
    txa
    and #7
    clc
    adc #$A8        ;żeby był adres
    ldx $D7
    sta MGT,x       ;adres bloku
    lda #0
    sta MPO,x
    sta MRO,x
    lda #1
    sta MWC,x
    sta MIK,x
    jsr SXY
    beq koniec_MOVE 
    txa
    and #7
    ldx $D7
    sta MRO,x
    jsr SXY
    beq koniec_MOVE
    dex             ;bo WOL ma już 1
    txa
    ldx $D7
    clc
    adc WOL,x
    sta WOL,x
    jsr SXY         ;to jest opcjonalne pobranie współrzędnych

koniec_MOVE:
    lda WOL
    and #$7F
    sta MWC,x       ;licznik
    lda WOL
    sta MWO,x       ;odblokowanie przerwania dla tego sprita
    rts

move_stop:
    jsr $0073
    bne :++         ;kontynuuj bez sprawdzania przecinka
    rts

:   jsr $E20E       ;Check For Comma, A=char after comma
:   jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    and #7
    tax
    lda #0
    sta MWO,x       ;zatrzyma przerwania dla tego sprita (ale go nie usunie z ekranu)
    jsr $0079       ;CHRGOT: Get same Byte again
    bne :--         ;sprawdź przecinek i pobierz bajt
    rts
.endproc
