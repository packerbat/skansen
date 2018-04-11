;------------------------------------
; obsługa tokena SHIFT
;   SHIFT [<ilość wierszy> = 18]
;
; jeśli ilość wierszy jest 0 to nic nie robi
; jeśli ilość wierszy jest 1 to zeruje $E2A0-$EB9F (256 bajtów)
;
; używa AD, AP jako zmienne lokalne
;
; input:
;   BASIC pcode
; output:
;

.export TkSHIFT
.import GETUP, AD:zeropage, AP:zeropage

.segment "DATA"

.segment "BSS"

.segment "CODE"
.proc TkSHIFT
    jsr GETUP       ;wynik w X
    lda #$A0
    ldy #$E2
    sta AD
    sty AD+1        ;destination pointer
    lda #$E0
    ldy #$E3
    sta AP
    sty AP+1        ;source pointer, 8 linii niżej
    ldy #0
    txa                 ;ilość wierszy
    beq koniec_SHIFT
    dex
    beq wyzeruj_ostatni_wiersz     ;jeden wiersz
    
    sei
    lda #$35        ;ukrywa oba ROM-y ale I/O pozostaje
    sta $01

:   lda (AP),y
    sta (AD),y
    iny
    bne :-

    lda AP+1
    sta AD+1
    lda AP
    sta AD
    inc AP+1
    clc
    adc #$40
    sta AP
    bcc :+
    inc AP+1
:   dex
    bne :--
    
    lda #$37
    sta $01
    cli

wyzeruj_ostatni_wiersz:
    lda #0          ;czyści zerami najniższy wiersz
:   sta (AD),y
    iny
    bne :-

koniec_SHIFT:
    rts
.endproc
