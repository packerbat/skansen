;------------------------------------
; obsługa tokena MUSIC wypełniającego prosotokątną pamięć koloru
; o współrzednej narożnika X,Y, szerokości DX i wysokości DY
; pobiera parametry: YK, YK+1, XK, XK+1, HICOLOR
;
; używa $02
;
; input:
;
; output:
;

.export TkMUSIC
.import GETN, VGT, VOC, PM:zeropage, DY:zeropage, KY:zeropage, AP:zeropage

.segment "CODE"
.proc TkMUSIC
    jsr $E209       ;Check Default Parameters
    cmp #$90        ;token STOP
    beq MSTO
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    and #$0F
    beq E40         ;nie może być 0, ma być 1-15
    clc
    adc #$B0
    sta PM+1
    lda #$00
    tay
    sta PM          ;Adres jest $B100, $B200, ... $BF00     (czyli po 256 bajtów na każdy głos)
    sta DY
:   sta (PM),y      ;czyści głos
    iny
    bne :-
:   jsr $E206       ;Check Default Parameters
    jsr $E254       ;Get Parameters For OPEN/CLOSE
    ldy #$00
:   jsr GETN
    sty KY
    ldy DY
    lda AP
    sta  (PM),y
    iny
    lda AP+1
    sta (PM),y
    iny
    beq E39
    sty DY
    ldy KY
    cpy $B7
    bcc :-
    bcs :--

E39:
    jmp $B97e       ;Output ?OVERFLOW Error

E40:
    jmp $B248       ;?ILLEGAL QUANTITY

MSTO:               ;MUSIC STOP 1,2,3 - wyłączy jednocześnie trzy generatory
    jsr $0073
    jsr $E209       ;Check Default Parameters, break if none
:   jsr $B79E       ;Evaluate Text to 1 Byte in XR
    dex             ;numeracja od 1 więc dekrement
    txa
    sta $02
    cmp #$03
    bcs E40         ;czyli gdy 4 i więcej
    asl $02
    adc $02
    asl $02
    adc $02         ;numer generatora *7
    tax
    lda #$00
    sta VGT,x       ;VGT(g)=0
    lda VOC,x
    and #$FE
    sta $D404,x     ;Control Register(g) = VOC(g) & 11111110 - start release
    jsr $E206       ;Check Default Parameters, kończy gdy nie więcej treści
    jsr $E20E       ;Check For Comma
    bne :-
.endproc
