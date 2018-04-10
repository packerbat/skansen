;------------------------------------
; sprawdza czy coś jest
; jeśli coś jest to sprawdza czy jest to znak '@'
; jeśli nie to pobiera 8-bitową liczbę całkowitą i zwraca w X
;
; całkowitych 16-bitowych i zapisuje do XC oraz YC.
; oba parametry są obowiązkowe
;
; input:
;   $D7 - numer sprita
;   $02 - bit sprita
; output:
;   X - odczytany parametr całkowity gdy Z=1
;   Z=0 - nie ma więcej parametrów

.export SXY

.segment "CODE"
.proc SXY
    jsr $0079
    beq :+++
    jsr $E20E       ;Check For Comma, A=char after comma
    cmp #'@'
    bne :++
    asl $D7         ;numer sprita * 2
    jsr $0073       ;CHRGET: Get next Byte of BASIC Text
    jsr $AD8A       ; Confirm Result
    jsr $B1AA       ; FAC#1 to Integer in A starszy ($64)/Y młodszy ($65)
    ldx $D7
    tya
    sta $D000,x     ;n-th Sprite X Pos
    lda $02         ;bit sprita
    ora $D010       ; Sprites 0-7 MSB of X coordinate
    lsr $64
    bcs :+
    eor $02
:   sta $D010       ; Sprites 0-7 MSB of X coordinate

    jsr $E20E       ;Check For Comma
    jsr $AD8A       ; Confirm Result
    jsr $B1AA       ; FAC#1 to Integer in A starszy ($64)/Y młodszy ($65)
    ldx $D7
    tya
    sta $D001,x     ;n-th Sprite Y Pos

    lsr $D7         ;$D7 znowu numer sprita
    lda $02
    ora $D015       ;Sprite display Enable
    sta $D015       ;Sprite display Enable          ;odblokowuje n-th sprite

    jsr $0079
    beq :++
    jsr $E20E       ;Check For Comma

:   jmp $B79E       ;Evaluate Text to 1 Byte in XR
    lda #1          ;zeby Z=0
:   rts
.endproc
