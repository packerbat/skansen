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

.export TkPLAY, STPLAY, DEL, WY, AN, VOC, VGT
.import WOL

.segment "DATA"
STPLAY: .byte 0     ;globalny start grania

DEL:   .byte 0      ;dane generatora 1
WY:    .word 0       ; jiffy clock, po którym nastąpi zmiana nuty
AN:    .word 0       ; adres nuty, która będzie grana jako następna
VOC:   .byte 0       ; control register
VGT:   .byte 0       ; 0=głos wyłączony, bity 6..0 to tempo, typowo 1

DEL2:  .byte 0      ;dane generatora 2
WY2:   .word 0
AN2:   .word 0
VOC2:  .byte 0
VGT2:  .byte 0

DEL3:  .byte 0      ;dane generatora 3
WY3:   .word 0
AN3:   .word 0
VOC3:  .byte 0
VGT3:  .byte 0

.segment "CODE"
.proc TkPLAY
    jsr $E209       ;Check Default Parameters
    cmp #$90        ;token STOP
    beq MSTO

:   lda STPLAY
    bmi :-          ;czekam aż się zwolni semafor
    ldx #0
    stx WOL
    cmp #$9A        ;token CONT
    bne :+
    jsr $0073
    ldx #$80
    stx WOL         ;obecność CONT ustawia najstarszy bit w WOL
:   jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    ora WOL
    sta WOL         ;WOL jest pierwszym parametrem z ustawionym najstarszym bitem albo nie
    lda #15
    sta $D418       ;Master Volume na maksa
    lda #0
:   sta $D7
    jsr $0079
    beq koniec_PLAY
    jsr $E200       ;Get Next One Byte Parameter ta procedura przerywa TkPLAY więc chyba źle
    txa
    ldx $D7
    and #$0F
    beq E78
    clc
    adc #$C0
    sta AN+1,x
    lda WOL
    sta VGT,x       ;VGT to pierwszy parametr z ustawionym najstarszym bitem albo nie
    lda #0
    sta AN,x        ;na początek AN=0, WY=0, VOC=zero na najmłodszym bicie
    sta WY,x
    sta WY+1,x
    lda VOC,x
    and #$FE
    sta VOC,x
E78:
    txa
    clc
    adc #7
    cmp #21
    bcc :-

koniec_PLAY:
    lda STPLAY
    ora #1
    sta STPLAY      ;to rozpocznie granie
    rts

MSTO:               ;PLAY STOP 1,2,3 - wyłączy jednocześnie trzy generatory
:   lda STPLAY
    bmi :-          ;czekam aż się zwolni semafor
    jsr $0073
    jsr $E209       ;Check Default Parameters, break if none
:   jsr $B79E       ;Evaluate Text to 1 Byte in XR
    dex             ;numeracja od 1 więc dekrement
    txa
    sta $02
    cmp #3
    bcs E40         ;czyli gdy 4 i więcej
    asl $02
    adc $02
    asl $02
    adc $02         ;numer generatora *7
    tax
    lda #0
    sta VGT,x       ;VGT(g)=0
    lda VOC,x
    and #$FE
    sta $D404,x     ;Control Register(g) = VOC(g) & 11111110 - start release
    jsr $E206       ;Check Default Parameters, kończy gdy nie więcej treści
    jsr $E20E       ;Check For Comma
    bne :-
    rts

E40:
    jmp $B248       ;?ILLEGAL QUANTITY
.endproc

