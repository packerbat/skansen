;------------------------------------
; obsługa tokena UP
;   UP <nr>,<nr>,...
;
; używa  jako zmienne lokalne
;
; input:
;   BASIC pcode
; output:
;

.export TkUP
.import WOL, GETSP, SXY, TBP

.segment "DATA"

.segment "BSS"

.segment "CODE"
.proc TkUP
    rts
.endproc
