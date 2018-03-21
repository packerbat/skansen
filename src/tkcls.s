;------------------------------------
; procedura TkCLS - ustawia 3 kolory, górny nibble, dolny nibble i boarder, parametry drugi i trzeci opcjonalne,
;   po ustawieniu kolorów czyści oba ekrany: graficzny i tekstowy
;   nie wiem po co czyszczę tryb tekstowy
; zmienia: wszystko

.export TkCLS
.import XC: zeropage
.import YC: zeropage

.segment "CODE"
.proc TkCLS
    jsr TkINK
    ldy #$00
    sty XC
    sty YC          ;zerowanie YC nie jest potrzebne, a samo YC nie jest wykrorzystane
    sty YC+1
    lda #$d3
    sta XC+1        ;YC=0000, XC=d300, ekran tekstowy d000-d3ff
    php
    sei             ;blokada przerwań z zachowaniem poprzedniego stanu blokady
    lda #$34        ;odłączenie BASIC i KERNAL, gdy się wyłączy oba to zniknie również I/O a ekran tekstowy pokrywa się z I/O
    sta $01
    lda hicolor     ;kolor
    ldx #$04
    ldy #$e7        ;rozmiar $03e8 = 1000
    jsr PST
    lda #$37        ;przywrócenie BASIC i KERNAL
    sta $01
    plp             ;to oblokuje przerwania

    lda #$ff        ;XC=ff00, ekran graficzny e000-ffff
    sta XC+1
    lda #$00        ;wypełnienie $00
    ldx #$20
    ldy #$3f        ;rozmiar $1f40 = 8000
    jsr PST
    rts
.endproc

.proc PST
:   sta (XC),Y
    dey
    bne :-
    sta (XC),Y
    dec XC+1
    dex
    bne :-
    stx XC+1     ;zeruję XC+1
    rts
.endproc

