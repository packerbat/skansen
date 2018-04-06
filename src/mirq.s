;------------------------------------
; Obsługa przerwania
; Mam już zapamiętane wszystkie rejestry na stosie przez KERNAL
; oraz wiem, że nie było to przerwanie spowodowane instrukcją BRK
; oraz wiem, że BASIC ROM jest wyłączony więc mam dostęp do tablicy wysokości nut
;
; MIRQ odtwarza muzykę przypisaną do 3 generatorów przez PLAY
; Ścieżki są skompilowane poleceniem MUSIC i może być 15 ścieżek
; Ścieżka składa się z 16-bitowych nut i komend sterujących:
;   1rrrrrrr vvvvvvvv oznacza komendę zapisującą vvvvvvvv do rejestru $D400 + rrrrrrr
;   00000000 ???????? oznacza koniec utworu
;   00000001 tttttttt oznacza pauze o długości tttttttt jednostek czasu
;   0nnnnnnn tttttttt oznacza nutę o wysokości nnnnnnn i długości tttttttt jednostek czasu

.export MIRQ
.import STPLAY, VGT, WY, VOC, DEL, AN, PM:zeropage

.segment "CODE"
; procedyra mnoży VGT(g) (młodsze 7 bitów to tempo) przez DEL(g)-1 (czas trwania nuty)
; X = adres struktury generatora g*7
; Wynik w WY(g), potem zostanie do tego dodana aktualna wartość zegra jiffy clock
; niszczy DEL(g) (zawsze 0)
.proc MNO
    lda #0
    sta PM+1
    sta WY,x        ;czemu nie ma "sta WY+1,x"?
    lda VGT,x
    and #$7F
    sta PM          ;PM = VGT(g) (młodsze 7 bitów)
    ldy #8          ;licznik pętli 8 razy
    dec DEL,x
:   lsr DEL,x
    bcc :+
    clc
    lda WY,x
    adc PM
    sta WY,x
    lda WY+1,x
    adc PM+1
    sta WY+1,x      ;WY(g) += PM
:   asl PM
    ROL PM+1        ;PM *= 2
    dey
    bne :--
    rts
.endproc

.proc MIRQ
    ldx #14         ;zaczynamy od generatora 3
L26:
    lda VGT,x       ;VGT(g) = 0 oznacza, że generator jest wyłączony
    beq E16
    lda $A2         ;najmłoszy jiffy clock
    cmp WY,x
    lda $A1         ;średni jiffy clock
    sbc WY+1
    bcc E16
    lda VGT,x       ;czas przekroczony więc zmieniam nutę
    and #$7F
    sta WY,x
    lda #0
    sta WY+1,x      ;do WY wstawiam VGT (młodsze 7 bitów) czyli tempo
    lda VOC,x
    lsr
    bcs E18         ;czy nuta była włączona

    lda AN+1,x      ;nie, nuta była wyłączona
    sta PM+1
E17:
    lda AN,x
    sta PM          ;PM =AN(g)
    ldy #1
    inc AN,x
    inc AN,x        ; AN(g) += 2 czyli przejście do następnej nuty ale bez uwzględnienia starszego bajta bo melodia jednego głosu nie wykracza poza blok 256 bajtów.

    lda (PM),y
    sta DEL,x       ;DEL to czas trwania nuty 
    dey
    lda (PM),y      ;A to wysokość nuty lub komenda
    beq koniec_sciezki
    bmi komenda_sterujaca

    sec             ;nuta+0 jest w zakresie 1..126, czyli jest to wysokość nuty albo pauza
    sbc #1
    beq obsluga_pauzy   ;nuta+0 = 1 to pauza a nuta+1 to czas pauzy, który trzeba przemnożyć przez VGT
    asl
    tay
    lda $A700,y     ;W $A700 jest tablica częstotliwości nut
    sta $D400,x
    lda $A701,y
    sta $D401,x
    jsr MNO         ;wyznaczam czas następnego przełączenia

E18:
    lda VOC,x       ;tak, nuta była włączona więc zmieniam GATE na przeciwny czyli wyłączam, WY jest już ustawione na 1 impuls VGT
    eor #1
    sta VOC,x
    sta $D404,x

E77:
    clc
    lda WY,x
    adc $A2
    sta WY,x
    lda WY+1,x
    adc $A1
    sta WY+1,x      ;WY(g) = VGT(g) * (DEL(g)-1) + jiffy clock

E16:
    txa             ;przesuwamy się do generatora wcześniejszego
    sec
    sbc #7
    tax
    bpl L26
    lda VGT
    ora VGT+7
    ora VGT+14
    bne :+
    lda STPLAY      ;zamilkły wszystkie 3 głosy więc koniec grania
    and #$FE
    sta STPLAY
:   rts

obsluga_pauzy:
    inc DEL         ;obsługa pauzy, nie ma 1/60 ciszy po pauzie
    jsr MNO         ;wyznaczam czas następnego przełączenia
    jmp E77

koniec_sciezki:
    sta AN,x        ;A = 0 oznacza koniec ścieżki, a AN(g)=0 oznacza ustaw się na początku ścieżki
    ldy VGT,x
    bmi E16         ;najstarszy bit ustawiony oznacza graj na okrągło
    sta VGT,x       ;VGT(g)=0 oznacza "wyłącz głos"
    bpl E16         ;ten skok wykona się zawsze bo STA nie zmienia flag

komenda_sterujaca:
    and #$7F        ;wysokość nuty ma bit 8 = 1, czyli to jest komenda, dolne 7 bitów to numer rejestru a następny bajt to wartość rejestru. jeśli dolne 7 bitów to same jedynki to nie jest to numer rejestru tylko rejestr VOC
    cmp #25         ;tyle rejestrów do zapisu ma SID
    bcs :+++        ;ignoruję bo wykracza poza zakres
    cmp #21
    bcs :++         ;to są rejestry niezależne od numeru generatora
    cmp #7
    bcs :+++        ;rejestry zależne od numeru generatora mogą mieć tylko adres 0-6
    cmp #4
    bne :+
    sta VOC,x       ;to jest rejestr sterujący i muszę znać jego nową wartość
:   stx PM          ;na chwilę
    clc
    adc PM          ;mam adres relatywny do głosu
:   tay             ;y = dolne 7 bitów nuta+0
    lda DEL,x       ;nuta+1 to nowa wartość rejestru
    sta $D400,y     ;Frequency Control - Low-Byte. Czy to czasami wali w próżnię?
:   jmp E17         ;wykonanie komendy oznacza dalsze szukanie nuty do zagrania
.endproc

