;------------------------------------
; Czeka przez ilość jednostek czasu podaną w zmiennej globalnej WOL (8 bitów)
; jednostka czasu to 1/60 sekundy. Procedura zakłada, że nie przeoczy
; żadnego tiknięcia i zakłada, że zegar zawsze będzie inkrementowany
; o wartość 1
;
; input:
;    WOL - czas oczekiwania
; output:
;    A - zmienione
;    Z - zawsze 1

.export CZEK
.import WOL 

.segment "CODE"
.proc CZEK
    lda WOL
    beq :++
    clc
    adc $A2     ;Real-time jiffy Clock
:   cmp $A2
    bne :-
:   rts
.endproc
