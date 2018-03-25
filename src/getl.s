;------------------------------------
; coś oblicza
; input:
;    Y - numer poprzedniej litery
;    $BB - string
;    $B7 - długość stringu
; output:
;    A - oczytana litera bez zmian jeśli powyżej '0', jeśli poniżej to A=0..9
;    Y - wskazuje na nierozpoznaną literę, lub za ostatnią literą jeśli string się skończył
;    C - 1 = zwykła litera, albo litera poniżej '0' ale przeniesiona $D0..$FF, albo string się skończył
;        0 = cyfra '0'..'9' przeniesiona na wartość 0..9
;    X - niezmienione

.export GETL

.segment "CODE"
.proc GETL
    iny
    cpy $B7         ;Number of Characters in Filename
    bcs :+
    lda ($BB),y     ;Pointer: Current File name Address
    cmp #$3a
    bcs :+
    sec
    sbc #$30
    cmp #$d0
:   rts
.endproc
