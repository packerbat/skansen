;---------------------------------------------------------- 
; sekwencja inicjująca rozszerzenie basica

.import TEV, DOIT, LIST, TOKEN, NOR, NSTOP, IRQ

.segment "CODE"
    ldx #$00
    ldy #$8C
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

    lda #<NOR       ;$E38B
    ldy #>NOR
    sta $300
    sty $301

    lda #<TOKEN     ;old TOKEN = $A57C
    ldy #>TOKEN
    sta $304
    sty $305

    lda #<LIST      ;old LIST = $A71A
    ldy #>LIST
    sta $306
    sty $307

    lda #<DOIT      ;old DOIT = $A7E4
    ldy #>DOIT
    sta $308
    sty $309

    lda #<TEV       ;old TEV = $A7E4
    ldy #>TEV
    sta $30A
    sty $30B

    lda #<NSTOP    ;podmiana obsługi klawisza STOP na moją procedurę
    ldy #>NSTOP
    sta $0328      ;Kernal Stop Routine Vector
    sty $0329

    lda #<IRQ
    ldy #>IRQ
    sei          ;podmiana przerwania na moją procedurę
    sta $0314    ;Hardware IRQ Interrupt Vector
    sty $0315
    cli

    rts           ;return from SYS(2069)

.segment "RODATA"
TX1: .byte 155,147,"    ..... Wordprocessor BASIC .....", 13, 13
     .byte         "        34816 BASIC bytes free", 13, 0

