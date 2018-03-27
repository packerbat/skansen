;------------------------------------
; procedura DOIT -
; zmienia: wszystko
; nie sprawdzam górnego zakresu tokena, to żle

.export DOIT

.segment "CODE"
.proc DOIT
    JSR $0073     ; CHRGET: Get next Byte of BASIC Text
    JSR DOIT1     ; Perform BASIC Keyword
    JMP $A7AE     ; BASIC Warm Start
.endproc

.proc DOIT1
    BEQ LA82B     ; Perform [restore]

LA7EF:
    SBC #$80
    BCC LA804
    CMP #$23
    BCS LA80E
    ASL
    TAY
    LDA $A00D,Y   ; BASIC Command Vectors - 1
    PHA
    LDA $A00C,Y   ; BASIC Command Vectors - 1
    PHA
    JMP $0073     ; CHRGET: Get next Byte of BASIC Text

LA804:
    JMP $A9A5     ; Perform [let]

LA807:
    CMP #$3A     ; ':'
    BEQ DOIT     ; Prepare to execute statement

LA80B:
    JMP $AF08     ; Output ?SYNTAX Error

LA80E:
    CMP #$4B      ;TOKEN GO=$CB
    BNE LA80B
    JSR $0073     ; CHRGET: Get next Byte of BASIC Text
    LDA #$A4      ;TOKEN TO=$A4
    JSR $AEFF     ; Test ','
    JMP $A8A0     ; Perform [goto]

LA82B:
    RTS
.endproc