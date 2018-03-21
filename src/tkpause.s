;------------------------------------
; procedura TkPAUSE - bez parametru czyści bufor klawiatury i czeka na wciśnięcie klawisza
;   jeśli jest parametr to go zamienia na Integer a potem czeka na wciśnięcie klawisza z ograniczeniem czasowym
; zmienia: wszystko

.export TkPAUSE

.segment "CODE"
.proc TkPAUSE
    beq :+
    jsr $AD8A       ;Confirm Result
    jsr $B7F7       ;Convert FAC#1 to Integer in LINNUM, wynik konwersji umieszcza w $14, $15
    jsr WAIT
    rts

:   ldx #$00
    stx $C6         ;Number of Characters in Keyboard Buffer queue
:   ldx $C6
    beq :-
    rts
.endproc
