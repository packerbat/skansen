;------------------------------------
; Pobiera 2 parametry rzeczywiste, zaokrągla je do liczb
; całkowitych 16-bitowych i zapisuje do XC oraz YC.
; oba parametry są obowiązkowe
;
; input:
;
; output:
;    XC - 16 bitowa liczba całkowita
;    YC - 16 bitowa liczba całkowita
;    XK - 16 bitowa liczba całkowita
;    YK - 16 bitowa liczba całkowita

.export GETN, AP
.import NUTA, GETL, NUM, HEX, CO:zeropage, DX:zeropage

.segment "FPAC1": zeropage
AP:   .res 2

.segment "CODE"
.proc GETN
    lda ($BB),y
    lda #$00
    cmp #'.'
    beq E37
    cmp #'!'
    beq E38
    cmp #'*'
    beq E80
    jsr NUTA
    sta CO
    jsr GETL
    bcs E36
    cmp #$08
    bcs E40
    sta $02
    asl
    adc $02
    asl
    asl
    sta CO+1
    iny
E36:
    dey
    lda CO+1
    clc
    adc CO
    tax
E37:
    inx
    stx AP
    jsr NUM
    lda DX
    beq :+
    sta AP+1
:   rts

E40:
    jmp $B248       ;?ILLEGAL QUANTITY

E38:
    iny
    jsr HEX
    ora #$80
E81:
    sta AP
    jsr HEX
    sta AP+1
    rts

E80:
    iny
    lda #$FF
    bne E81
.endproc
