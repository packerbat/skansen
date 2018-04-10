;------------------------------------
; rysuje jeden pixel na ekranie graficznym
; w nowej wersji ta procedura nie zmienia koloru
; kolor trzeba ustawić przed lub po narysowaniu za pomocą FILL
; 

.export POT, TBP
.import XC, YC, PTYP, HICOLOR

.segment "FPAC1": zeropage
AD:   .res 2

.segment "CODE"
.proc POT
    lda #0
    sta AD+1
    ldx YC
    ldy YC+1
    lda XC
    cmp #$40
    lda XC+1
    sbc #1
    bcs nic_nie_rysuj
    tya
    bne nic_nie_rysuj
    cpx #$c8
    bcs nic_nie_rysuj
    txa
    and #7
    tay
    txa
    and #$F8
    sta AD
    asl
    rol AD+1
    asl
    rol AD+1
    adc AD
    bcc :+
    inc AD+1
:   ldx AD+1
    asl
    rol AD+1
    asl
    rol AD+1
    asl
    rol AD+1
    sta AD
    lda XC
    tax
    and #$F8
    adc AD
    sta AD
    lda XC+1
    adc AD+1
    adc #$E0
    sta AD+1
    txa
    and #7
    eor #7
    tax

    sei
    lda $01
    pha
    lda #$34        ;turn off BASIC and KERNAL
    sta $01
    lda TBP,x
    ldx PTYP        ;typ rysowania, 0 = neg/and (zgaś), 1 = or (zapal), 2 = xor (zaneguj)
    bne :+
    eor #$ff
    and (AD),y
    jmp :+++
:   cpx #2
    beq :+
    ora (AD),y
    bne :++
:   eor (AD),y
:   sta (AD),y
    pla
    sta $01         ;restore BASIC and KERNAL to previous state
    cli

nic_nie_rysuj:
    rts
.endproc

.segment "RODATA"
TBP:    .byte 1,2,4,8,16,32,64,128