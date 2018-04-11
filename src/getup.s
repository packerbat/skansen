;------------------------------------
; Pobiera opcjonalny parametr całkowity o domyślnej wartości
; 18 ale nie większy niż 24
;
; input:
;   BASIC pcode pointed by ($7A)
; output:
;    X - wartość parametru albo 18 jeśli parametr nie wystąpił

.export GETUP

.segment "CODE"
.proc GETUP
    ldx #18
    jsr $0079
    beq :+
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    cpx #24
    bcs :++
:   rts

:   jmp $B248       ;?ILLEGAL QUANTITY
.endproc
