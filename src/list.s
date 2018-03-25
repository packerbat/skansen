;------------------------------------
; procedura rozszerza listowanie programu o moje tokeny
; zmienia: wszystko

.export LIST
.import TOKTB

.segment "CODE"
.proc LIST
    bpl :+
    cmp #$ff
    beq :+          ;$ff też wyświetl literę
    bit $0f         ;DATA scan/List Quote/Garbage collection
    bpl :++         ;jeśli bit 7 jest ustawiony to mamy cytowanie stringu więc też wyświetlam literę
:   jmp $A6F3       ;wyświetl literę

:   cmp #$cd
    bcs :+
    jmp $A724       ;to nie jest mój token, więc standadowe listowanie

:   sbc #$CC        ;szukam mojego tokena w TOKTB z X=1 dla pierwszego tokena
    tax
    sty $49         ;Pointer: Index Variable for FOR/NEXT loop
    ldy #$ff
:   dex
    beq :++
:   iny
    lda TOKTB,y
    bpl :-
    bmi :--

:   iny             ;znalazłem więc go drukuję
    lda TOKTB,y
    bmi :+
    jsr $ab47       ;Output Format Character ale końcówka
    bne :-
    jmp $A742       ;ciąg dalszy we wbudowanym Perform [for] ale to się chyba nigdy nie zdarzy
:   jmp $A6EF       ;ciąg dalszy we wbudowanym LIST
.endproc
