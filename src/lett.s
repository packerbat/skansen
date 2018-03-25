;------------------------------------
; rysuje jedną literę na ekranie graficznym
; używa górnego bajta zmiennej KY
; używa $02 z zeropage
; input:
;    A - litera do namalowania
;    SX - liczba powtórzeń tej litery, domyślnie 1
;    WOL - odstęp czasu między literami w 1/60 sek.
; 

.export LETT
.import CZEK, POT, FND, SX, DX:zeropage, DY:zeropage, XC:zeropage, YC:zeropage, KY:zeropage, PM:zeropage

.segment "CODE"
.proc LETT
    tay
    lda #$36        ;remove BASIC
    sta $01
    jsr FND
    beq koniec_lett
    clc             ;w PM mam literę
    adc #$01
    sta $02         ;$02 ma długość wzorca + 1
    sty DY          ;DY=0
L13:
    ldx SX          ;liczba powtórzeń litery
    stx KY+1
L14:
    inc DY
    inc DY          ;DY=2
L15:
    iny
    cpy $02
    bcs koniec_lett
    lda (PM),y
    sty DX+1        ;DX+1 przechowalnia dla Y
    ldx #$08
    stx DY+1        ;DY+1 lokalny licznik do 8
L19:
    asl
    bcc :+
    pha             ;bit jest 1 wić trzeba namalować
    jsr POT
    pla
:   inc YC          ;obniżam pozycję na ekranie
    bne :+
    inc YC+1
:   dec DY+1
    bne L19         ;licznik po 8 w pionie
    ldy DX+1        ;Y z przechowalni wraca na tablicę PM
    dec DY
    bne L15         ;litery mają po 2 bajty w pionie
    jsr CZEK        ;odczelanie WOL jednostek czasu
    inc XC
    bne :+
    inc XC+1
:   lda YC          ;zmiększyłem XC
    sec
    sbc #$10
    sta YC
    bcs :+
    dec YC+1
:   dec KY+1        ;odjąłem 16 od YC
    beq L13         ;trzeba powtórzyć jeszcze raz ten znak
    dey
    dey
    JMP L14

koniec_lett:
    lda #$37
    sta $01         ;turn on BASIC
    lda DX
    clc
    adc XC
    sta XC
    bcc :+
    inc XC+1
:   rts
.endproc
