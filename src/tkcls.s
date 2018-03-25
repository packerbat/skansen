;------------------------------------
; procedura TkCLS - ustawia 3 kolory, górny nibble, dolny nibble i boarder, parametry drugi i trzeci opcjonalne,
;   po ustawieniu kolorów czyści ekrany graficzny i tablicę kolorów ekranu graficznego, który pokrywa się
;   z adresem ekranu tekstowego
; XC i YC to są ostatnie współrzędne po rysowaniu jakiegoś elementu
;   po czyszczeniu ekranu XC=0 i YC=0 czyli lewy górny narożnik
; zmienia: wszystko

.export TkCLS, XC, YC
.import TkINK, HICOLOR

.segment "UPTRS": zeropage
YC:   .res 2
XC:   .res 2

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
    lda HICOLOR     ;kolor
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
:   sta (XC),y
    dey
    bne :-
    sta (XC),y
    dec XC+1
    dex
    bne :-
    stx XC+1     ;zeruję XC+1
    rts
.endproc

