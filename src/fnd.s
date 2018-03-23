;------------------------------------
; coś szuka
; 

.export FND
.export DX

.segment "CODE"
TABL: .word $0000,$A000,$A1A0,$0000, $0000,$A520,$A368,$0000

.segment "FPMUL": zeropage
DX:   .res 2

.segment "UTIL": zeropage
PM:   .res 2

.segment "FPAC2": zeropage
KY:   .res 2

.segment "CODE"
.proc FND
    tay
    cmp #123
    beq SPC
    ldx ODS
FNDS:
    stx DX
    lsr
    lsr
    lsr
    lsr
    and #$0E
    tax
    lda TABL,x
    sta PM
    lda TABL+1,x
    sta PM+1
    beq :+++
    tya
    and #$1F
    beq :++++
    ldy #$00
    tax
:   dex
    beq :+
    lda ($24),y
    clc
    adc #$01
    adc PM
    sta PM
    bcc :-
    inc PM+1
    bcs :-
:   lda ($24),y
:   rts

:   asl DX
    asl DX
    asl DX
    lda #$00
    rts

SPC:
    ldy KY
    jsr NUM
    dey
    sty KY
    lda #$00
    rts
.endproc

