;------------------------------------
; Pobiera opcjonalny parametr całkowity o domyślnej wartości
; 18. Procedura sprawdza przedział wartości 1..23
; i zgłasza błąd jeśli jest niepoprawny.
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
    cpx #0
    beq :++
    cpx #24
    bcs :++
:   rts

:   jmp $B248       ;?ILLEGAL QUANTITY
.endproc
