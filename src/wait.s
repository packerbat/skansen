;------------------------------------
; procedura WAIT czeka określony czas chyba, że wcześniej ktoś wciśnie klawisz
; zmienia: wszystko
; do $14 i $15 trzeba wpisać czas oczekiwania w 1/60 sekundy
; ta procedura jest niebezpieczna bo zegar się zawija przy wartości $4F1A00=5184000=86400s=1440m=24h=1d
; nie sprawdzam również $A0 (HI byte) a powinienem
; procedura zakłada, że w wartościach $A2 i $A1 nie będzie przeskoku (czy przeskok jest możliwy?)

.export WAIT

.segment "CODE"
.proc WAIT
    clc
    ldx #$00        ;czyszczenie bufora klawiatury
    stx $C6         ;Number of Characters in Keyboard Buffer queue

    lda $A2         ;Real-time jiffy Clock + 2 (LO byte)
    adc $14         ;Temporary: Integer value
    tay
    lda $A1         ;Real-time jiffy Clock + 1 (MID byte)
    adc $15         ;Temporary: Integer value + 1

                    ;w Y jest młodszy bajt, w A jest starszy bajt czasu oczekiwania
:   ldx $C6         ;Number of Characters in Keyboard Buffer queue
    bne :+
    cpy $A2         ;Real-time jiffy Clock + 2
    bne :-
    cmp $A1         ;Real-time jiffy Clock + 1
    bne :-
:   rts
.endproc