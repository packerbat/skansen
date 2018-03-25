;------------------------------------
; input:
;    A - ostatni znak stringu
; ouput:
;    X - zawsze 1
;    PTYP - zawsze 1
;    XC, YC - zmienione jesli A='@', w przeciwnym razie nie zmienione
;    $B7, $BB - kopia parametru typu string

.export CXY
.import PTYP, XYC

.segment "CODE"
.proc CXY
    cmp #64         ;znak @
    bne :+
    jsr $0073       ;CHRGET: Get next Byte of BASIC Text
    jsr XYC         ;pobiera dwa obowiązkowe parametry całkowite i umieszcza w XC i YC
    jsr $E20E       ;Check For Comma
:   jsr $E257       ;Get Parameters For OPEN/CLOSE, Get Filename
    ldx #$01
    stx PTYP        ;plot type ustawia na OR
    rts
.endproc
