;------------------------------------
; obsługa tokena PLOT zmieniającego piksel na ekranie graficznym o podanych współrzędnych X,Y
; pobiera parametry: XC, YC, PTYP (opcjonalnie)
;
; input:
;
; output:
;

.export TkPLOT
.import XYC, GETA, POT

.segment "CODE"
.proc TkPLOT
    jsr XYC
    jsr GETA
    jsr POT
    rts
.endproc

