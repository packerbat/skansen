;------------------------------------
; procedura TEV - rozpoznaje tokeny od E2 do E5
; zmienia: wszystko

.export TEV
.import FnSCROLL, FnTEXT, FnPLAY, FnSPRITE

.segment "CODE"
.proc TEV
    lda #0
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

:   plp             ;restore status after "Get next Byte of BASIC Text"
    jmp $AE8D       ;Continue Evaluate Single Term
.endproc

.segment "RODATA"
FNVEC: .word FnTEXT-1, FnSPRITE-1, FnSCROLL-1, FnPLAY-1
