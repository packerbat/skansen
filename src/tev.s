;------------------------------------
; procedura TEV -
; zmienia: wszystko

.export TEV

.segment "CODE"
.proc TEV
    lda #$00
    sta $0D         ;Data type Flag, $00 = Numeric, $FF = String
    jsr $0073       ;CHRGET: Get next Byte of BASIC Text
    sec
    sbc #$E1        ;moje funkcje mają kody od $E0
    bcc :+
    asl
    tay
    lda FNVEC+1,y
    pha
    lda FNVEC,y
    pha
    jmp $0073       ;CHRGET: Get next Byte of BASIC Text
:   jsr $0079       ;CHRGOT: Get same Byte again
    jmp $AE8D       ;Continue Evaluate Single Term
.endproc

.segment "RODATA"
FN1 = 1     ;usunąć po zdefiniowaniu własciwych funkcji
FN2 = 2
FN4 = 4
FNVEC: .word FN1-1, FN2-1, FnSCROLL-1, FN4-1
