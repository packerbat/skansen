;------------------------------------
; Zamienia cyfry ASCII ('0'..'9') na liczbę 8-bitową
; jeśli nie ma żadnej cyfry to DX=0
;
; input:
;    Y - numer poprzedniej litery
;    $BB - string
;    $B7 - długość stringu
; output:
;    A = wynik konwersji
;    DX = wynik konwersji
;    Y = wskazuje na nierozpoznaną literę, lub za ostatnią literą jeśli string się skończył
;    C = zawsze 1
;    X - nie zmienione

.export NUM
.import DX:zeropage, GETL

.segment "CODE"
.proc NUM
    lda #$00
    sta DX
:   jsr GETL
    bcs :+      ;zwykła litera lub koniec stringu
    pha
    lda DX      ;DX*10
    asl
    asl
    clc
    adc DX
    asl
    sta DX
    clc
    pla
    adc DX      ;A=cyfra+DX*10
    sta DX      ;DX=cyfra+DX*10
    jmp :-
:   rts
.endproc
