;------------------------------------
; obsługa tokena LINE rysującego odcinek od XC,YC do XK,YK
; w trybie rysowania PTYP
; pobiera parametry: XC, YC, XK, YK, PTYP (opcjonalnie = 1)
;
; input:
;
; output:
;

.export TkLINE, KX, XK, YK
.import GETPK, POT, KY:zeropage, XC, YC, DX:zeropage, DY:zeropage, PM:zeropage

.segment "FPAC2": zeropage
KX:   .res 2

.segment "DATA"
XK:    .word 0
YK:    .word 0

.segment "CODE"
.proc TkLINE
    jsr GETPK
    ldx #$01
    stx KX
    stx KY
    dex
    stx KX+1
    stx KY+1        ;KX = 1, KY = 1
    dex
    sec
    lda XK
    sbc XC
    sta DX
    lda XK+1
    sbc XC+1
    sta DX+1        ;DX = XK-XC
    bpl :+
    stx KX          ;KX = -1
    stx KX+1
    sec
    lda XC
    sbc XK
    sta DX
    lda XC+1
    sbc XK+1
    sta DX+1        ;DX = XC-XK
:   sec
    lda YK
    sbc YC
    sta DY
    lda YK+1
    sbc YC+1
    sta DY+1
    bpl :+
    stx KY
    stx KY+1        ;KY = -1
    sec
    lda YC
    sbc YK
    sta DY
    lda YC+1
    sbc YK+1
    sta DY+1        ;DY = YK-YC
:   asl DX
    rol DX+1        ;DX *= 2
    asl DY
    rol DY+1        ;DY *= 2
    lda DX
    cmp DY
    lda DX+1
    sbc DY+1
    bcc iterate_by_Y

iterate_by_X:
    lda DX+1
    lsr
    sta PM+1
    lda DX
    ror
    sta PM        ; PM = DX/2
:   lda XC
    ldy XC+1
    cmp XK
    bne :+
    cpy XK+1
    bne :+
    rts         ;XK=XC czyli koniec rysowania

:   sec
    lda PM
    sbc DY
    sta PM
    lda PM+1
    sbc DY+1
    sta PM+1        ;PM -= DY
    bpl :+
    clc
    lda YC
    adc KY
    sta YC
    lda YC+1
    adc KY+1
    sta YC+1        ;YC += KY
    clc
    lda PM
    adc DX
    sta PM
    lda PM+1
    adc DX+1
    sta PM+1        ;PM += DX
:   clc
    lda XC
    adc KX
    sta XC
    lda XC+1
    adc KX+1
    sta XC+1        ;XC += KX
    jsr POT
    jmp :---

iterate_by_Y:
    lda DY+1
    lsr
    sta PM+1
    lda DY
    ror
    sta PM        ; PM = DY/2
:   lda YC
    ldy YC+1
    cmp YK
    bne :+
    cpy YK+1
    bne :+
    rts         ;YK=YC czyli koniec rysowania

:   sec
    lda PM
    sbc DX
    sta PM
    lda PM+1
    sbc DX+1
    sta PM+1        ;PM -= DX
    bpl :+
    clc
    lda XC
    adc KX
    sta XC
    lda XC+1
    adc KX+1
    sta XC+1        ;XC += KX
    clc
    lda PM
    adc DY
    sta PM
    lda PM+1
    adc DY+1
    sta PM+1        ;PM += DY
:   clc
    lda YC
    adc KY
    sta YC
    lda YC+1
    adc KY+1
    sta YC+1        ;XC += KX
    jsr POT
    jmp :---
.endproc

