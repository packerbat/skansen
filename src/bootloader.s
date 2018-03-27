;---------------------------------------------------------- 
; sekwencja inicjująca rozszerzenie Basica

.segment "ZEROPAGE"
YC:   .res 2
XC:   .res 2

.segment "CODE"
    .word $080D       ;wskaźnik to następnej linii
    .word 1987        ;numer linii i jednocześnie rok powstania
    .byte $9E         ;SYS token
    .asciiz "(2069)"  ;SYS argument
    .word $0813       ;wskaźnik to następnej linii
    .word 2018        ;numer linii i jednocześnie rok powstania
    .byte $A2         ;NEW token
    .byte $00         ;end of basic line
    .word $0000       ;wskaźnik na następną linię, $0000 oznacza, że jest to ostania linia

    lda #$00
    ldy #$10
    sta XC
    sty XC+1
    ldx #$90
    sta YC
    stx YC+1
    tay
:   lda (XC),y
    sta (YC),y
    dey
    bne :-
    inc XC+1
    inc YC+1
    lda YC+1
    cmp #$A0      ;kopiuje 4KB, od $9000 do $9FFF włącznie
    bne :-
    jmp $9000     ;will init wpbasic and return to SYS(2069)
    .res 1992,0   ;wypełnienie zerami reszty segmentu, co za marnotrawstwo

.segment "BINARY"
    .incbin "wpbasic.bin"

