;---------------------------------------------------------- 
; sekwencja inicjująca rozszerzenie basica

.import TEV, DOIT, LIST, TOKEN, NOR, NSTOP, IRQ

.segment "CODE"
    ldx #$00
    ldy #$90
    clc
    jsr $fe25       ;Read / Set Top of Memory, zachowuje A,X,Y
    stx $37         ;Pointer: Highest Address available to BASIC
    sty $38
    stx $33         ;Pointer: Bottom of String space
    sty $34

    lda #$16     ;%0001 0110 = video matrix base address 1, character base addres 3 to ROM z małymi literami
    sta $D018    ;VIC Memory Control Register, adres grafiki od $0400 do $07FF

    lda #<TX1     ;napis powitalny
    ldy #>TX1
    jsr $AB1E     ;Output String

    ldx #$0B          ;podmiana 6-ciu kolejnych werktorów BASICA
:   lda NVC,x
    sta $0300,x       ;Vector: BASIC Error Message
    dex
    bpl :-

    lda #<NSTOP    ;podmiana obsługi klawisza STOP na moją procedurę
    ldy #>NSTOP
    sta $0328      ;Kernal Stop Routine Vector
    sty $0329

    sei          ;podmiana przerwania na moją procedurę
    lda #<IRQ
    ldy #>IRQ
    sta $0314    ;Hardware IRQ Interrupt Vector
    sty $0315
    cli

    rts           ;return from SYS(2069)

.segment "RODATA"
NVC: .word  NOR,  $A483, TOKEN, LIST,  DOIT,   TEV
;OVC: .word $E38B, $A483, $A57C, $A71A, $A7E4, $AE86
;            NOR,  $A483, TOKEN,  LIST,  DOIT,  TEV

TX1: .byte 155,147,"    ..... Wordprocessor BASIC .....", $0D, $0D
     .byte         "        34816 BASIC bytes free", $0D, $00

