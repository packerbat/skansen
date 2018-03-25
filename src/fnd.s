;------------------------------------
; szuka adresu z wzorcem litery.
;
; input:
;    Y - szukana litera
; output:
;    A - długość znalezionej litery albo 0 jeśli litera już została namalowana
;    PM - wskaźnik na literę
;    dolne DX - szerokość znaku
;    Z - 1=znak już został namalowany, 0=trzeba malować znak w PM

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
    and #$0E        ;litera podzielona przez 16 i zaokrąglona do parzystych
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
    sty KY      ;Y cofa się do znaku przed nierozpoznaną liczbą
    lda #$00    ;Z=1 oznacza koniec malowania
    rts
.endproc

