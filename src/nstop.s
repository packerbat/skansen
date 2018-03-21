;------------------------------------
; procedura obsługi klawisza STOP
; zmienia: wszystko
; stos: 3+

.export NSTOP

.segment "CODE"
.proc NSTOP
    lda $91     ;Stop Key Flag
    cmp #$7f
    bne :+
    php
    jsr $FFCC   ;Kernal Restore I/O Vector, zawsze zwraca 0 w ACC
    sta $C6     ;Keyboard Buffer Len
    jsr NRM
    plp
:   rts
.endproc
