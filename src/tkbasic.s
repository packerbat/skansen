;------------------------------------
; procedura TkBASIC -
; zmienia: wszystko

.export TkBASIC

.segment "CODE"
.proc TkBASIC
    jsr $E453       ;Initialize Vectors
    jsr $FD15       ;Restore Kernal Vectors
    ldx #$80
    jmp ($0300)     ;Vector: BASIC Error Message
.endproc
