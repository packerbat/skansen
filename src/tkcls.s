;------------------------------------
; procedura TkCLS - ustawia 3 kolory, górny nibble, dolny nibble i boarder, parametry drugi i trzeci opcjonalne,
;   po ustawieniu kolorów czyści ekrany graficzny i tablicę kolorów ekranu graficznego, który pokrywa się
;   z adresem ekranu tekstowego
; XC i YC to są ostatnie współrzędne po rysowaniu jakiegoś elementu
;   po czyszczeniu ekranu XC=0 i YC=0 czyli lewy górny narożnik
; zmienia: wszystko

.export TkCLS
.import TkINK, HICOLOR, XC, YC, DX:zeropage

.segment "CODE"
.proc TkCLS
    jsr TkINK
    ldy #0
    sty XC
    sty XC+1
    sty YC
    sty YC+1
    sty DX
    lda #$d3
    sta DX+1        ;DY=0000, DX=d300, ekran tekstowy d000-d3ff
    php
    sei             ;blokada przerwań z zachowaniem poprzedniego stanu blokady
    lda #$34        ;odłączenie BASIC i KERNAL, gdy się wyłączy oba to zniknie również I/O a ekran tekstowy pokrywa się z I/O
    sta $01
    lda HICOLOR     ;kolor
    ldx #4          ;4x256 = 1KB
    ldy #$e7        ;rozmiar $03e8 = 1000
    jsr PST
    lda #$37        ;przywrócenie BASIC i KERNAL
    sta $01
    plp             ;to oblokuje przerwania

    lda #$ff        ;DX=ff00, ekran graficzny e000-ffff
    sta DX+1
    lda #0          ;wypełnienie $00
    ldx #32         ;32x256 = 8KB
    ldy #$3f        ;rozmiar $1f40 = 8000
    jsr PST
    rts
.endproc

.proc PST
:   sta (DX),y
    dey
    bne :-
    sta (DX),y
    dey             ;następny blok będzie mazany od $FF
    dec DX+1
    dex
    bne :-
    rts
.endproc

