;------------------------------------
; procedura TEV -
; zmienia: wszystko

.export TEV
.import FnSCROLL

.segment "CODE"
.proc TEV
    LDA #$00
    STA $0D       ; Data type Flag

LAE8A:
    JSR $0073     ; CHRGET: Get next Byte of BASIC Text
    BCS LAE92

LAE8F:
    JMP $BCF3     ; Convert ASCII String to a Number in FAC

LAE92:
    JSR $B113     ; Does A hold an alphabetic character?
    BCC LAE9A
    JMP $AF28     ; Search for Variable

LAE9A:
    CMP #$FF      ; token PI
    BNE LAEAD     ; Continue Expression
    LDA #$A8
    LDY #$AE      ; PI value
    JSR $BBA2     ; Load FAC#1 From Memory
    JMP $0073     ; CHRGET: Get next Byte of BASIC Text


LAEAD: CMP #$2E
    BEQ LAE8F     ; Evaluate Single Term
    CMP #$AB
    BEQ LAF0D     ; Set up NOT Function
    CMP #$AA
    BEQ LAE8A     ; Evaluate Single Term
    CMP #$22
    BNE LAECC

LAEBD:
    LDA $7A       ; Pointer: Current Byte of BASIC Text
    LDY $7B       ; Pointer: Current Byte of BASIC Text
    ADC #$00
    BCC LAEC6
    INY
LAEC6:
    JSR $B487     ; Set Up String
    JMP $B7E2     ; Convert ASCII String to Flpt

LAECC:
    CMP #$A8
    BNE LAEE3
    LDY #$18
    BNE LAF0F     ; Set up NOT Function
    JSR $B1BF     ; FAC#1 to Positive Integer
    LDA $65       ; FAC Mantissa
    EOR #$FF
    TAY
    LDA $64       ; FAC Mantissa
    EOR #$FF
    JMP $B391     ; Convert Integer in (AC/YR) to Flpt

LAEE3:
    CMP #$A5
    BNE LAEEA
    JMP $B3F4     ; Perform [fn]

LAEEA:
    CMP #$B4
    BCC LAEF1     ; Expression in Brackets
    JMP $AFA7     ; Identify Function Type

LAEF1:
    JSR $AEFA     ; Test '('
    JSR $AD9E     ; Evaluate Expression in Text

LAF0D:
    LDY #$15
LAF0F:
    PLA
    PLA
    JMP $ADFA     ; Evaluate Expression in Text
.endproc
