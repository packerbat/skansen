;------------------------------------
; Pobiera 1 liczbę 8-bitową i oblicza blok pamięci dla ścieżki 
;
; input:
;
; output:
;    PM - adres jednego z 8 bloków o długości 256 bajtów w obszarze $A800-$AFFF
;    A/Y - adres bloku przy czym Y jest zawsze 0

.export GETB
.import PM:zeropage

.segment "CODE"
.proc GETB
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    and #7
    clc
    adc #$A8
    sta PM+1
    ldy #0
    sty PM
    rts
.endproc
