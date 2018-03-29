;------------------------------------
; obsługa funkcji TEXT, która oblicza szerokość podanego napisu w pikselach
; pobiera parametry: treść, skala pozioma (SX) i odstępy między literami (ODS)
; Używa dolny bajt KY do przechowywania numeru oblicznaje litery
; Procedura nie powinna brać odstępu za ostatnią literą, powinna również pomijać
; ostatnie, niewidoczne spacje.
;
; użuwa $02
;
; input:
;    BASIC tokenized program
; output:
;    C - zawsze 1

.export FnTEXT
.import SX, ODS, FND, COD, CO:zeropage, DX:zeropage, KY:zeropage

.segment "CODE"
.proc FnTEXT
    jsr $aefa       ;Check '('
    jsr $E257       ;Get Parameters For OPEN/CLOSE
    jsr $E200       ;Get Next One Byte Parameter
    stx SX
    jsr $E200       ;Get Next One Byte Parameter
    stx ODS
    jsr $AEF7       ;Test ')'
    ldy #$00
    sty CO
    sty CO+1
    lda $B7
    beq :++++
    lda #$36        ;hide BASIC ROM
    sta $01
:   sty KY
    lda ($BB),y     ;Pointer: Current File name Address
    tay
    jsr FND
    beq :++         ; litera jest już namalowana i w DX jest całkowita szerokość

    ldx SX          ;horizontal scale, ten fragment powinien być mnożeniem a nie pętlą
    lsr             ;szerokosc litery w pikselach
    sta $02
:   lda $02
    jsr COD         ; SX razy  CO += szerokość litery, ale na koniec trzeba dodać DX, które ma wartość ODS
    dex
    bne :-

:   lda DX
    jsr COD
    ldy KY
    iny
    cpy $B7         ;Number of Characters in Filename
    bcc :---
    lda #$37        ;hide BASIC ROM
    sta $01
:   ldy CO
    lda CO+1
    jmp $B391
.endproc
