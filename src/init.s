;---------------------------------------------------------- 
; sekwencja inicjująca rozszerzenie basica

.export YC
.export XC

.segment "CODE"
    ldx #$00
    ldy #$90
    clc
    jsr $fe25       ;Read / Set Top of Memory, zachowuje A,X,Y
    stx $37         ;Pointer: Highest Address available to BASIC
    sty $38
    stx $33         ;Pointer: Bottom of String space
    sty $34

    lda #<TX1     ;napis powitalny
    ldy #>TX1
    jsr $AB1E     ;Output String

    lda #0       ;wyczyszczenie rejestrów XK, YK, SX, ODS, DEL, WY, AN, VOC
    ldx #$0B     ;zakłada, że są pod rząd bez odstępów
:   sta XK,X
    dex
    bpl :-

    ldx #$0B          ;podmiana 6-ciu kolejnych werktorów BASICA
:   lda NVC,X
    sta $0300,X       ;Vector: BASIC Error Message
    dex
    bpl :-

    lda #<NSTOP    ;podmiana obsługi klawisza STOP na moją procedurę
    ldy #>NSTOP
    sta $0328      ;Kernal Stop Routine Vector
    sty $0329

    ;sei          ;podmiana przerwania na moją procedurę
    ;lda #<IRQ
    ;ldy #>IRQ
    ;sta $0314    ;Hardware IRQ Interrupt Vector
    ;sty $0315
    ;cli

    rts           ;return from SYS(2063)

.segment "RODATA"
NVC: .word  NOR,  $A483, TOKEN, LIST,  DOIT,   TEV
OVC: .word $E38B, $A483, $A57C, $A71A, $A7E4, $AE86

;  NOR, $A483, TOKEN,  LIST,  DOIT,  TEV

TX1: .byte 155,147,"   ..... wordproccesor basic .....", $0D, $0D
     .byte         "         (c) wildesoft  1987", $0D, $00

.segment "ZEROPAGE"
YC:   .res 2
XC:   .res 2

.segment "BSS"
XK:    .res 2
YK:    .res 2
SX:    .res 1
ODS:   .res 1
DEL:   .res 1
WY:    .res 2
AN:    .res 2
VOC:   .res 1
