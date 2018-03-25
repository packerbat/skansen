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

.export XYC
.import XC:zeropage, YC:zeropage

.segment "CODE"
.proc XYC
    jsr $AD8A       ;Confirm Result
    jsr $B1AA       ;FAC#1 to Integer in A/Y
    sty XC
    sta XC+1
    jsr $E20E       ;Check For Comma
    jsr $AD8A       ;Confirm Result
    jsr $B1AA       ;FAC#1 to Integer in A/Y
    sty YC
    sta YC+1
    rts
.endproc
