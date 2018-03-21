;------------------------------------
; procedura TkVOLUME - pobiera jeden parametr obowiąkowy i wstawia go do D418, liczba 0-15 to głośność z wyłączonymi wszystkimi filtrami.
; zmienia: wszystko

.export TkVOLUME

.segment "CODE"
.proc TkVOLUME
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    stx $D418       ;Select Filter Mode and Volume
    rts
.endproc
