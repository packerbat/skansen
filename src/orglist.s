;------------------------------------
; procedura rozszerza listowanie programu o moje tokeny
; zmienia: wszystko

.export LIST

.segment "CODE"
.proc LIST
    BPL LA6F3     ; Perform [list]
    CMP #$FF
    BEQ LA6F3     ; Perform [list]
    BIT $0F       ; Flag: DATA scan/List Quote/Garbage collection
    BMI LA6F3     ; Perform [list]
    SEC
    SBC #$7F
    TAX
    STY $49       ; Pointer: Index Variable for FOR/NEXT loop
    LDY #$FF

LA72C:
    DEX
    BEQ LA737

LA72F:
    INY
    LDA $A09E,Y   ; BASIC Command Keyword Table
    BPL LA72F
    BMI LA72C

LA737:
    INY
    LDA $A09E,Y   ; BASIC Command Keyword Table
    BMI LA6EF     ; Perform [list]
    JSR $AB47     ; Output Format Character
    BNE LA737
    JMP $A742     ; Nie wiem dlaczego ale Perform [list], przechodzi w Perform [for]



LA6C9:
    LDY #$01
    STY $0F       ; Flag: DATA scan/List Quote/Garbage collection
    LDA ($5F),Y   ; Temporary storage for FLPT value
    BEQ LA714
    JSR $A82C     ; Perform [stop]
    JSR $AAD7     ; Output CR/LF
    INY
    LDA ($5F),Y   ; Temporary storage for FLPT value
    TAX
    INY
    LDA ($5F),Y   ; Temporary storage for FLPT value
    CMP $15       ; Temporary: Integer value
    BNE LA6E6
    CPX $14       ; Temporary: Integer value
    BEQ LA6E8
    BCS LA714

LA6E8:
    STY $49       ; Pointer: Index Variable for FOR/NEXT loop
    JSR $BDCD     ; Output Positive Integer in A/X
    LDA #$20

LA6EF:
    LDY $49       ; Pointer: Index Variable for FOR/NEXT loop
    AND #$7F

LA6F3:
    JSR $AB47     ; Output Format Character
    CMP #$22
    BNE LA700
    LDA $0F       ; Flag: DATA scan/List Quote/Garbage collection
    EOR #$FF
    STA $0F       ; Flag: DATA scan/List Quote/Garbage collection

LA700:
    INY
    BEQ $A714
    LDA ($5F),Y   ; Temporary storage for FLPT value
    BNE LA717     ; Handle LIST Character
    TAY
    LDA ($5F),Y   ; Temporary storage for FLPT value
    TAX
    INY
    LDA ($5F),Y   ; Temporary storage for FLPT value
    STX $5F       ; Temporary storage for FLPT value
    STA $60       ; Temporary storage for FLPT value
    BNE $A6C9

LA714:
    JMP $E386     ; BASIC Warm Start [RUNSTOP-RESTORE]

LA717:
    JMP ($0306)   ; Vector: BASIC LIST Routine
.endproc
