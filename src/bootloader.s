;---------------------------------------------------------- 
; sekwencja inicjująca rozszerzenie Basica

.segment "ZEROPAGE":zeropage
SRCPTR:   .res 2
DSTPTR:   .res 2

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

    lda #$09
    sta SRCPTR+1
    lda #$90
    sta DSTPTR+1
    ldy #0
    sty SRCPTR
    sty DSTPTR
    ldx #16             ;16 bloków po 256 bajtów
:   lda (SRCPTR),y
    sta (DSTPTR),y
    dey
    bne :-
    inc SRCPTR+1
    inc DSTPTR+1
    dex
    bne :-
    jmp $9000     ;will init wpbasic and return to SYS(2069)

    .res $0900-*,0   ;wypełnienie zerami reszty segmentu, co za marnotrawstwo

.segment "BINARY"
    .incbin "wpbasic.bin"

