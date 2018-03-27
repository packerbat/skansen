;------------------------------------
; oryginalna procedura wyświetlająca komunikat błędu

.export NOR

.segment "CODE"
.proc NOR
    txa
    bmi LE391
    jmp $A43A     ; Error Routine
LE391:
    jmp $A474
.endproc
