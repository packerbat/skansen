;------------------------------------
; procedura DOIT -
; zmienia: wszystko
; nie sprawdzam górnego zakresu tokena, to żle

.export DOIT

.segment "CODE"
.proc DOIT
    jsr $0073   ;CHRGET: Get next Byte of BASIC Text
    jsr DOIT1
    jmp $A7AE   ;BASIC Warm Start
.endproc

.proc DOIT1
    beq LA82B     ; Perform [restore]

LA7EF:
    sbc #$80
    bcc LA804
    cmp #$23
    bcs LA80E
    asl
    tay
    lda $A00D,y
    pha
    lda $A00C,y
    pha
    jmp $0073   ;CHRGET: Get next Byte of BASIC Text

LA804:
    jmp $A9A5     ; Perform [let]

LA807:
    cmp #$3A     ; ':'
    beq DOIT     ; Prepare to execute statement

LA80B:
    jmp $AF08     ; Output ?SYNTAX Error

LA80E:
    cmp #$4B      ;TOKEN GO=$CB
    bne LA80B
    jsr $0073     ; CHRGET: Get next Byte of BASIC Text
    lda #$A4      ;TOKEN TO=$A4
    jsr $AEFF     ; Test ','
    jmp $A8A0     ; Perform [goto]

LA82B:
    rts
.endproc
