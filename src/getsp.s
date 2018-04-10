;------------------------------------
; Pobiera 1 liczbę 8-bitową, zeruj bity z wyjątkiem 3 najmłodszych
; i ustawia 1 na bicie o tym numerze
;
; input:
;   BASIC pcode
; output:
;    $D7 - 3 dolne bity parametru
;    $02 - 2^(3 dolne bity parametru)
;    A - równe $02

.export GETSP
.import TBP

.segment "CODE"
.proc GETSP
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    and #7
    sta $D7
    tax
    lda TBP,x
    sta $02
    rts
.endproc
