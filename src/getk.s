;------------------------------------
; Pobiera 2 parametry rzeczywiste, zaokrągla je do liczb
; całkowitych 16-bitowych i zapisuje do XC oraz YC.
; oba parametry są obowiązkowe
;
; input:
;
; output:
;    XK - 16 bitowa liczba całkowita
;    YK - 16 bitowa liczba całkowita
;    PTYP - opcjonalnie z wartością domyślną 1

.export GETK
.import GETA, PTYP, XK, YK

.segment "CODE"
.proc GETK
    jsr $AD8A
    jsr $B1AA
    sty XK
    sta XK+1
    jsr $E20E
    jsr $AD8A
    jsr $B1AA
    sty YK
    sta YK+1
    ldy #01
    sty PTYP
    jmp GETA
.endproc
