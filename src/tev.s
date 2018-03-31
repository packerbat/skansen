;------------------------------------
; procedura TEV - rozpoznaje tokeny od E2 do E5
; zmienia: wszystko

.export TEV
.import FnSCROLL, FnTEXT

.segment "CODE"
.proc TEV
    lda #$00
    sta $0D         ;Data type Flag, $00 = Numeric, $FF = String
    jsr $0073       ;CHRGET: Get next Byte of BASIC Text
    php
    cmp #$e2
    bcc :+          ;$00..$E1 - nie moje
    cmp #$e6
    bcs :+          ;$e6..$ff - nie moje

    plp
    sec
    sbc #$e2        ;moje funkcje mają kody od $E2
    asl
    tay
    lda FNVEC+1,y
    pha
    lda FNVEC,y
    pha
    jmp $0073       ;CHRGET: Get next Byte of BASIC Text

:   plp             ;CHRGOT: Get same Byte again
    jmp $AE8D       ;Continue Evaluate Single Term
.endproc

.segment "RODATA"
FN2 = 2
FN4 = 4
FNVEC: .word FnTEXT-1, FN2-1, FnSCROLL-1, FN4-1
