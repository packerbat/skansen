;------------------------------------
; procedura TEV - rozpoznaje tokeny od E1 do E4
; zmienia: wszystko

.export TEV
.import FnSCROLL

.segment "CODE"
.proc TEV
    lda #$00
    sta $0D         ;Data type Flag, $00 = Numeric, $FF = String
    jsr $0073       ;CHRGET: Get next Byte of BASIC Text
    php
    cmp #$e1
    bcc :+          ;$00..$E0 - nie moje
    cmp #$e5
    bcs :+          ;$e5..$ff - nie moje

    plp
    sec
    sbc #$e1        ;moje funkcje mają kody od $E1
    asl
    pha
    jsr $0073       ;CHRGET: Get next Byte of BASIC Text
    jsr $aefa       ;Check '('
    pla
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
FN1 = 1     ;usunąć po zdefiniowaniu własciwych funkcji
FN2 = 2
FN4 = 4
FNVEC: .word FN1-1, FN2-1, FnSCROLL-1, FN4-1
