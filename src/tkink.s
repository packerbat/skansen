;------------------------------------
; procedura TkINK - ustawia 3 kolory, górny nibble, dolny nibble i boarder, parametry drugi i trzeci opcjonalne
; zmienia: wszystko
; korzysta z $02 w zeropage

.export TkINK
.export HICOLOR

.segment "CODE"
.proc TkINK
    jsr $E209       ;Check Default Parameters, przerywa TkINK jesli nie ma
    jsr $B79E       ;Evaluate Text to 1 Byte in XR
    txa
    asl
    asl
    asl
    asl
    sta $02         ;unused zeropage byte
    ldx HICOLOR
    jsr $0079       ;CHRGOT: Get same Byte again
    beq :+
    jsr $e200       ;Get Next One Byte Parameter
:   txa
    and #$0f
    ora $02
    sta HICOLOR

    jsr $E206    ;Basic Check Default Parameters, przerywa TkINK jeśli nie ma parametru
    jsr $E200    ;Basic Get Next One Byte Parameter
    stx $D020    ;VIC Border Color
    rts
.endproc

.segment "BSS"
HICOLOR:    .res 1
