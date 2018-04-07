;---------------------------------------------------------- 
; sekwencja inicjująca rozszerzenie Basica

.segment "CODE"
    .org $0801

    .word $080D       ;wskaźnik to następnej linii
    .word 1987        ;numer linii i jednocześnie rok powstania
    .byte $9E         ;SYS token
    .asciiz "(2069)"  ;SYS argument
    .word $0813       ;wskaźnik to następnej linii
    .word 2018        ;numer linii i jednocześnie rok powstania
    .byte $A2         ;NEW token
    .byte 0           ;end of basic line
    .word 0           ;wskaźnik na następną linię, $0000 oznacza, że jest to ostania linia

    lda #<loadingrom     ;napis powitalny
    ldy #>loadingrom
    jsr $AB1E     ;Output String

    lda #7              ;długość nazwy pliku
    ldx #<romfilename
    ldy #>romfilename
    jsr $FFBD           ;SETNAM
    lda #1              ;numer strumienia
    ldx #8              ;stacja dyskietek
    ldy #0              ;secondary address, e.g. 15 to read the error channel
    jsr $FFBA           ;SETLFS
    lda #0              ;0=LOAD, 1=VERIFY
    ldx #$00            ;only used if secondary address above = 0
    ldy #$90
    jsr $FFD5           ;LOAD

    lda #<loadingfonts     ;napis powitalny
    ldy #>loadingfonts
    jsr $AB1E     ;Output String

    lda #9              ;długość nazwy pliku
    ldx #<fontfilename
    ldy #>fontfilename
    jsr $FFBD           ;SETNAM
    lda #1              ;numer strumienia
    ldx #8              ;stacja dyskietek
    ldy #0              ;secondary address, e.g. 15 to read the error channel
    jsr $FFBA           ;SETLFS
    lda #0              ;0=LOAD, 1=VERIFY
    ldx #$00            ;only used if secondary address above = 0
    ldy #$A0
    jsr $FFD5           ;LOAD

    jmp $9000     ;will init wpbasic and return to SYS(2069)

romfilename:   .byte "wpbasic"
loadingrom:    .byte 13,"loading wpbasic...",0
fontfilename:  .byte "plfontslg"
loadingfonts:  .byte 13,"loading plfontslg...",0

