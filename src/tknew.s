;------------------------------------
; Czyści cały BASIC ale nie rusza stosu

.export TkNEW

.segment "CODE"
.proc TkNEW
    LDA #$00
    TAY
    STA ($2B),Y   ; Pointer: Start of BASIC Text Area
    INY
    STA ($2B),Y   ; Pointer: Start of BASIC Text Area
    LDA $2B       ; Pointer: Start of BASIC Text Area
    CLC
    ADC #$02
    STA $2D       ; Pointer: Start of BASIC Variables
    LDA $2C       ; Pointer: Start of BASIC Text Area
    ADC #$00
    STA $2E       ; Pointer: Start of BASIC Variables
    JSR $A68E     ; Reset TXTPTR
    JSR $FFE7     ; Close All Channels And Files
    LDA $37       ; Pointer: Highest Address available to BASIC
    LDY $38       ; Pointer: Highest Address available to BASIC
    STA $33       ; Pointer: Bottom of String space
    STY $34       ; Pointer: Bottom of String space
    LDA $2D       ; Pointer: Start of BASIC Variables
    LDY $2E       ; Pointer: Start of BASIC Variables
    STA $2F       ; Pointer: Start of BASIC Arrays
    STY $30       ; Pointer: Start of BASIC Arrays
    STA $31       ; Pointer: End of BASIC Arrays + 1
    STY $32       ; Pointer: End of BASIC Arrays + 1
    JSR $A81D     ; Perform [restore]
    LDX #$19
    STX $16       ; Pointer: Temporary String Stack
    LDA #$00
    STA $3E       ; Pointer: BASIC Statement for CONT
    STA $10       ; Flag: Subscript reference/User Function call
    RTS
.endproc

