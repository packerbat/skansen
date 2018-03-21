;------------------------------------
; Ustawia color, dwa parametry drugi opcjonalny. pierwszy parametr to kolor litery ($0286), drugi parametr to kolor tła (VIC Background Color 0)
; zmienia: A

.export TkCOLOUR

.segment "CODE"
.proc TkCOLOUR
    jsr $E209    ;Check Default Parameters without get again
    jsr $B79E    ;Evaluate Text to 1 Byte in XR
    stx $0286    ;Current Character Color code

    jsr $E206    ;Basic Check Default Parameters, przerywa CRFG jeśli nie ma parametru
    jsr $E200    ;Basic Get Next One Byte Parameter
    stx $D021    ;VIC Background Color 0

    jsr $E206    ;Basic Check Default Parameters, przerywa CRFG jeśli nie ma parametru
    jsr $E200    ;Basic Get Next One Byte Parameter
    stx $D020    ;VIC Border Color
    rts
.endproc