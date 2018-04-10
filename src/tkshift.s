;------------------------------------
; obsługa tokena SHIFT
;   UP <nr>,<nr>,...
;
; używa  jako zmienne lokalne
;
; input:
;   BASIC pcode
; output:
;

.export TkSHIFT
.import WOL, GETSP, SXY, TBP

.segment "DATA"

.segment "BSS"

.segment "CODE"
.proc TkSHIFT
    rts
.endproc
