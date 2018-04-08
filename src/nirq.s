;------------------------------------
; Obsługa przerwania skrolującego napis
; Mam już zapamiętane wszystkie rejestry na stosie przez KERNAL
; oraz wiem, że nie było to przerwanie spowodowane instrukcją BRK
; oraz wiem, że BASIC i KERNAL są wyłączone
;
; NGAT - dolne 7 bitów to prędkość przewijania w 1/60 sekundy, domyślnie 1
; SAD - adres rysowanej litery
; POS - numer kolumny rysowanej litery
; SDX - licznik ilości wolnych kolumn za literą
; CONT - licznik szybkości
; SSX - szerokość lite, domyślnie 1 czyli litery nie poszerzone
; SSX+1 - licznik poszerzania


.export NIRQ
.import NXLT, NGAT, SAD, SDX, SSX, POS, CONT, PM:zeropage

.segment "CODE"
.proc NIRQ
    lda NGAT
    and #$7F
    sta CONT    ;CONT to NGAT bez najstarszego bitu
    ldx #7
:   asl $FBA0,x     ;8 razy scroluje pamięć ekranu
    asl $FCE0,x
    dex
    bpl :-
    ldx #8
:   asl $FBA0,x
    bcc :+
    inc $FB98,x
:   asl $FCE0,x
    bcc :+
    inc $FCD8,x
:   inx
    bne  :---

    lda SAD+1
    beq DOSP        ;litera jest już namalowana, teraz tylko odstęp
    sta PM+1
    lda SAD
    sta PM
    lda POS
    ldy #0
    cmp (PM),y      ;porównuje rysowany X litery z szerokością litery
    bcs DOSP
    tay
    ldx #7
    lda (PM),y      ;Y=POS
:   lsr
    bcc :+
    inc $FC98,x
:   dex
    bpl :--
    iny
    ldx #7
    lda (PM),y
:   lsr
    bcc :+
    inc $FDD8,x
:   dex
    bpl :--
    iny
    dec SSX+1
    bne :+
    sty POS
    lda SSX
    sta SSX+1
:   rts

DOSP:
    dec SDX         ;odstęp po literze nie podlega skalowaniu przez SSX
    bne :-
    jmp NXLT        ;skończył się odstęp po literze więc przygotuję następną literę
.endproc

