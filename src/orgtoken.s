;------------------------------------
; procedura TOKEN kompiluje tekst wprowadzony do $0200-$0258 i wynik kompilacji umieszcza w tym samym miejscu
; zmienia: wszystko

.export TOKEN

.segment "CODE"
.proc TOKEN
    ldx $7A         ;Pointer: Current Byte of BASIC Text, X jest wskaźnikiem SRC
    ldy #$04        ;Y jest skaźnikiem DEST, przed postawieniem będzie INY więc żeby było $200 to musi być $200-5 czyli $01FB
    sty $0F         ;Flag: DATA scan/List Quote/Garbage collection

L1: lda $0200,x     ;BASIC Input Buffer (Input Line from Screen)
    bpl LA58E       ;to jest litera więc przeskakuję do analizy liter
    cmp #$ff        ;litera $ff jest traktowana jak token $ff
    beq NXLET       ;litery od $80 do $FE są milcząco ignorowane
    inx
    bne L1          ;chyba zakładam, że tu zawsze będzie skok do L1

LA58E:
    cmp #$20
    beq NXLET       ;spacje są ignorowane
    sta $08         ;Flag: Scan for Quote at end of String
    cmp #$22        ;czy to jest cudzysłów
    beq CYTUJ
    bit $0F         ;Flag: DATA scan/List Quote/Garbage collection
    bvs NXLET
    cmp #$3F        ;skrót od PRINT
    bne LA5A4
    lda #$99        ;numer tokena procedury PRINT
    bne NXLET

LA5A4:
    cmp #$30
    bcc LA5AC
    cmp #$3C
    bcc NXLET       ;litery '0' do '9', ':' i ';' zapamietuję w skompilowanym kodzie

LA5AC:
    sty $71         ;Pointer: Used during CRUNCH/ASCII conversion
    ldy #$00
    sty $0B         ;Input Buffer Pointer/Number of Subscripts
    dey
    stx $7A         ;Pointer: Current Byte of BASIC Text
    dex

COMP:
    iny
    inx

COMP1:
    lda $0200,x     ;BASIC Input Buffer (Input Line from Screen)
    sec
    sbc $A09E,y     ;BASIC Command Keyword Table
    beq COMP
    cmp #$80
    bne NXTOK
    ora $0B         ;Input Buffer Pointer/Number of Subscripts

ROZPOZ1:
    ldy $71         ;Pointer: Used during CRUNCH/ASCII conversion

NXLET:              ;rozpoznałem token i mam go w A, trzeba go zapamiętać i dalej kompilować, jeśli A=0 to skończyła się linijka
    inx
    iny
    sta $01FB,y
    lda $01FB,y
    beq KONIEC
    sec
    sbc #$3A
    beq LA5DC
    cmp #$49
    bne LA5DE

LA5DC:
    sta $0F         ;Flag: DATA scan/List Quote/Garbage collection

LA5DE:
    sec
    sbc #$55
    bne L1
    sta $08         ;Flag: Scan for Quote at end of String

REMARK:
    lda $0200,x     ;BASIC Input Buffer (Input Line from Screen)
    beq NXLET
    cmp $08         ;Flag: Scan for Quote at end of String, w $08 może być " albo inny znak końca cytowania
    beq NXLET
CYTUJ:
    iny             ;ropozczynam cytowanie od litery, którą mam w A czyli "
    sta $01FB,y
    inx
    bne REMARK

NXTOK:
    ldx $7A         ;Pointer: Current Byte of BASIC Text
    inc $0B         ;Input Buffer Pointer/Number of Subscripts

LA5F9:
    iny
    lda $A09D,y     ;BASIC Operator Vectors
    bpl LA5F9
    lda $A09E,y     ;BASIC Command Keyword Table
    bne COMP1
    lda $0200,x     ;BASIC Input Buffer (Input Line from Screen)
    bpl ROZPOZ1

KONIEC:
    sta $01FD,y     ;0 na końcu skompilowanego kodu oraz zresetowanie wskaźnika wejścia na $01ff
    dec $7B         ;Pointer: Current Byte of BASIC Text + 1
    lda #$ff
    sta $7A         ;Pointer: Current Byte of BASIC Text
    rts
.endproc
