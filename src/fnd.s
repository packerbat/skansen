;------------------------------------
; Szuka adresu z wzorcem litery.
; Wzorce liter są pod BASIC-iem
;    $A000-$A19F - chr$(33)-chr$(63), znaki interpunkcyjne i cyfry
;    $A1A0-$A367 - chr$(65)-chr$(95), małe litery
;    $A368-$A51F - chr$(65+128)-chr$(95+128), wielkie litery
;    $A520-$AFFF - chr$(33+128)-chr$(63+128), polskie znaki
; input:
;    Y - szukana litera
;    KY - numer znaku w rysowanym stringu (dolny bajt)
; output:
;    A - długość znalezionej litery albo 0 jeśli litera już została namalowana
;    PM - wskaźnik na literę
;    dolne DX - szerokość znaku
;    Z - 1=znak już został namalowany, 0=trzeba malować znak w PM
;    Y - ma wartość 0 gdy litera znaleziona

.export FND
.export DX, DY, PM
.import KY:zeropage, ODS, NUM

;to są tablice z literami schowane pod BASIC-iem
.segment "CODE"
TABL: .word $0000,$A000,$A1A0,$0000, $0000,$A520,$A368,$0000

.segment "FPMUL": zeropage
DX:   .res 2
DY:   .res 2

.segment "UTIL": zeropage
PM:   .res 2

.segment "CODE"
.proc FND
    tya
    cmp #29        ;reverse "]", move cursor right
    beq SPC
    ldx ODS
FNDS:
    stx DX
    lsr
    lsr
    lsr
    lsr
    and #$0E        ;litera podzielona przez 32 a potem pomnożona przez 2 wyznacza jeden z 8 bloków pamięci
    tax
    lda TABL,x
    sta PM
    lda TABL+1,x
    sta PM+1        ;PM jest A000,A1A0,A520,A368 albo 0
    beq :+++        ;0 to koniec szukania z flagą Z=1
    tya             ;A = znak
    and #$1F        ;dolne 5 bitów
    beq :++++
    ldy #$00        ;adres w tablicy
    tax             ;numer litery w tablicy
:   dex
    beq :+
    lda (PM),y      ;pierszy bajt to chyba ilość bajtów zajętych przez literę
    clc             ;teraz PM trzeba zwiększyć o długość litery + 1
    adc #$01
    adc PM
    sta PM
    bcc :-
    inc PM+1
    bcs :-          ;to zastępuje JMP bo inc nie zmienia C

:   lda (PM),y      ;znalazłem, więc pobieram długość bo ona nie może być 0
:   rts

:   asl DX          ;dolne 5 bitów litery to same zera
    asl DX
    asl DX
    lda #$00        ;odstęp z ODS (domyślnie 1) jest mnożony przez 8 i Z=1 kończy rysowanie
    rts

SPC:            ;rysowanie spacji o podanej ilości pikseli
    ldy KY      ;numer bieżącej litery
    jsr NUM     ;pobiera parametr całkowity (8bit) do DX
    dey
    sty KY      ;Y cofa się do znaku ostatniej cyfry 0..9
    lda #$00    ;Z=1 oznacza koniec malowania
    rts
.endproc

