;------------------------------------
; procedura wyświetlająca komunikat błędu
;   jej zdaniem jest przełączyć się w tryb tekstowy jeśli był graficzny
;   przed przełączeniem się w tryb tekstowy, procedura czeka na wciśnięcie klawisza
;   X - chyba numer błędu
; zmienia: wszystko
; stos: 2+

.export NOR

.segment "CODE"
.proc NOR
     lda $D011    ;VIC Control Register 1
     and #$20
     beq :+++
     txa
     bpl :++
:    lda $C6      ;Keyboard Buffer Len
     beq :-
     dec $C6      ;Keyboard Buffer Len
:    jsr NRM
:    jmp $E38B    ;oryginalna procedura wyświetlająca błąd Basica
.endproc
