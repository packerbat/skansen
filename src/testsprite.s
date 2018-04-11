.segment "CODE"
.proc test_sprite
    php         ;statyczny sprite
    sei
    lda #$34
    sta $01

    lda #$50        ;kształ
    ldx #0          ;sprit
    sta $D3F8,x     ;8 wskźników na definicje sprita

    ldy #62
:   lda KSZTALT,y
    sta $D400,y
    dey
    bpl :-

    lda #$37
    sta $01
    plp             ;odblokowuje przerwania jeśli były poprzednio odblokowane

    lda $D015
    ora #1
    sta $D015       ;enable sprite 0
    lda #1
    sta $D027       ;sprite 0 color 1
    lda $D01C
    and #$FE
    sta $D01C       ;sprite 0 monochrome
    lda $D01D
    and #$FE
    sta $D01D       ;sprite 0 no X expand
    lda $D017
    and #$FE
    sta $D017       ;sprite 0 no Y expand
    lda #249
    sta $D000       ;sprite 0 x position
    lda #60         
    sta $D001       ;sprite 0 y position
    lda $D010
    and #$FE
    sta $D010       ;sprite 0 no X position MSB
    lda $D01B
    and #$FE
    sta $D01B       ;sprite 0 protity, MOB in front
    rts
.endproc

.segment "RODATA"
KSZTALT:
    .byte 96,0,6
    .byte 240,0,15
    .byte 248,0,31
    .byte 252,0,63
    .byte 238,0,119
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,0,231
    .byte 231,129,231
    .byte 231,195,231
    .byte 255,255,255
    .byte 255,255,255
    .byte 127,255,254
    .byte 7,255,224    