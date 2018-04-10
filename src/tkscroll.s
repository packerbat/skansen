;------------------------------------
; obsługa tokena SCROLL przesuwającego napis
; Skrolowany napis znajduje się w $B000-$B0FF
; pobiera parametry: SCROLL [CONT] "text"[, SSX=1[, SODX=1[, WOL=1]]]
;
; używa $02
;
; input:
;
; output:
;

.export TkSCROLL, NGAT, KOL
.import GETS, NUM, NXLT, WOL, SSX, DX:zeropage

.segment "DATA"
NGAT:  .byte 0       ;predkość przewijania, znacznik zawinięcia, odblokowanie przerwania NIRQ

.segment "BSS"
KOL:   .res 1       ;numer rysowanej litery

.segment "CODE"
.proc TkSCROLL
    cmp #$90        ;token STOP
    beq SOF
    jsr GETS
    ldy #0          ;source pointer
    ldx #0          ;destination pointer
L34:
    lda ($BB),y
    sta $B000,x
    cmp #29         ;cursor right
    bne :+
    jsr NUM
    dey
    lda DX
    inx
    sta $B000,x
:   inx
    iny
    cpy $B7
    bcc L34

    lda #0
    sta $B000,x
    sta KOL
    lda SSX
    sta SSX+1

    lda #$36    ;wyłącz BASIC
    sta $01
    jsr NXLT
    lda #$37
    sta $01
    lda WOL
    sta NGAT
    rts

SOF:
    lda #0
    sta NGAT
    jmp $0073
.endproc
