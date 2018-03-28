;------------------------------------
; Pobiera 2 parametry rzeczywiste, zaokrągla je do liczb
; całkowitych 16-bitowych i zapisuje do XC oraz YC.
; oba parametry są obowiązkowe
;
; input:
;
; output:
;    XC - 16 bitowa liczba całkowita
;    YC - 16 bitowa liczba całkowita
;    XK - 16 bitowa liczba całkowita
;    YK - 16 bitowa liczba całkowita

.export GETPK
.import XYC, GETK

.segment "CODE"
.proc GETPK
    beq :+++
    cmp #$A4        ;Token TO
    beq :+
    jsr XYC
    jsr $E20E
    bne :++
:   jsr $0073       ;CHRGET: Get next Byte of BASIC Text
:   jsr GETK
:   rts
.endproc
