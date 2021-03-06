;------------------------------------
; obsługa tokena PLAY [CONT] tempo, track1[, trakc2[, track3]]
;           albo PLAY STOP gen1[, gen2[, gen3]]
;
; używa $D7
;
; input:
;
; output:
;

.export SIRQ
.import MGT, MWC, MPO, MIK, MRO, MWO, TBM, TBS, TBP, PM:zeropage

.segment "BSS"
MKR:   .res 8           ;aktualny kierunek poruszania się

.segment "DATA"

.segment "CODE"
.proc SIRQ
    ldx #7
nastepny_sprite:
    lda MWO,x
    beq pomin_ten_sprite
    dec MWC,x
    bne pomin_ten_sprite
    and #$7F
    sta MWC,x       ;przeładowanie licznika z MWO
    dec MIK,x       ;chyba to jest licznik aktualnie wykonywanego poruszania się
    beq E98         ;skok do zmiany kierunku

CDN:
    lda $D7
    pha
    lda MKR,x       ;kierunek
    clc
    adc MRO,x       ;aktualna rotacja
    and #7
    tay             ;obrót w Y
    txa             ;A - numer sprita
    asl
    tax             ;A - numer sprita *2
    lda $D001,x     ;współrzędna Y
    clc
    adc TBM,y       ;dodajemy TBM dla Y - dobrze, prze przejmuję się przekroczeniem
    sta $D001,x
    lda #0
    sta $D7
    lda $D010
    and TBP,x       ;najstarszy bit sprita
    beq :+
    inc $D7         ;$D7 ma najstarszy bit, jak widać nie uwzględniam liczb ujemnych, to błąd
:   lda $D000,x
    clc
    adc TBM+2,y
    sta $D000,x     ;do X dodałem TBM+2 - dobrze, ale tu może być przekroczenie C=1 przy dodawaniu, C=0 przy odejmowaniu
    lda $D7
    adc TBS+2,y
    php             ;potrzebuję flagę Z
    txa
    lsr
    tax             ;X nowu jest numerem sprita
    lda $D010
    ora TBP,x        ;to ustawi
    plp             ;odzyskana flaga Z
    bne :+
    eor TBP,x       ;a to zgasi bo starszy bajt sumy był 0
:   sta $D010
    pla
    sta $D7

pomin_ten_sprite:
    dex
    bpl nastepny_sprite
    rts

E99:
    sta MPO,x       ;A=0
    ldy MWO,x
    bmi E98         ;zapętlona animacja
    sta MWO,x               ;MWO=0 czyli zatrzymanie
    bpl pomin_ten_sprite    ;ponieważ sta nie zmienia flag więc to jest skok bezwględny

E98:
    lda MGT,x       ;czas na zmianę kierunku
    sta PM+1
    lda MPO,x
    sta PM
    ldy #0
    inc MPO,x
    inc MPO,x   ;przesuwam się na następny, 16-bitowy rozkaz przesunięcia
    lda (PM),y
    beq E99
    cmp #'*'
    beq E42
    cmp #'!'
    beq E102
    sta MKR,x       ;MKR przechowuje aktualnie wykonywany rozkaz ruchu
    iny
    lda (PM),y
    sta MIK,x       ;licznik ilości kroków w kierunku MKR
    jmp CDN

E42:
    iny         ;obsługa '*'
    lda #$34    ;wyłączam oba ROMY a zatem i I/O
    sta $01
    lda (PM),y
    sta $D3F8,x     ;ustawia nowy shape sprita
    lda #$36
    sta $01
    bne E98     ;to jest skok bezwzględny i pobieram następny element ścieżki bez czekania

E102:
    iny         ;obsługa '!'
    lda (PM),y
    sta MWC,x       ;wartość po '!' idzie do MWC czyli do licznika prędkości odtwarzania
    tya
    sta MIK,x               ;tu wpisuję adres ścieżki?
    bne pomin_ten_sprite    ;to jest skok bezwzględny, bo Y przesłane do A jest 1 albo więcej

.endproc

