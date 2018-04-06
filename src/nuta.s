;------------------------------------
; bajt w A jest porównywany z tablicą nut
; jeśli trafi na nutę w jednej lub drugiej tablicy zwraca wartość w X w zakresie 0..13
; jeśli nie trafi to skacze do błędu ILLEGAL QUANTITY
;
; input:
;    A - sprawdzana nuta
; output:
;    X - wartość nuty na skali chromatycznej
;    Z - zawsze 1

.export NUTA

.segment "RODATA"
TABN: .byte 188,'c','C','d','D','e','f','F','g','G','a','A','h','H'
      .byte 188,'c',172,'d',177,187,163,165,'g',176,'a',116,'h',104

.segment "CODE"
.proc NUTA
    ldx #$0D
:   cmp TABN,x
    beq :+
    cmp TABN+14,x
    beq :+
    dex
    bpl :-
    jmp $B248        ;?ILLEGAL QUANTITY

:   rts
.endproc
