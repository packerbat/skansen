;------------------------------------
; procedura TOKEN kompiluje tekst wprowadzony do $0200-$0258 i wynik kompilacji umieszcza w tym samym miejscu
; zmienia: wszystko

.export TOKEN
.export TOKTB

.segment "CODE"
.proc TOKEN
    ldx $7A         ;Pointer: Current Byte of BASIC Text, X jest wskaźnikiem SRC
    ldy #$04        ;Y jest skaźnikiem DEST, przed postawieniem będzie INY więc żeby było $200 to musi być $200-5 czyli $01FB
    sty $0F         ;Flag: DATA scan/List Quote/Garbage collection

L1: lda $0200,x     ;BASIC Input Buffer (Input Line from Screen)
    bpl :+          ;to jest litera więc przeskakuję do analizy liter
    cmp #$ff        ;litera $ff jest traktowana jak token $ff
    beq NXLET       ;litery od $80 do $FE są milcząco ignorowane
    inx
    bne L1          ;chyba zakładam, że tu zawsze będzie skok do L1

:   cmp #$20
    beq NXLET       ;spacje są ignorowane
    sta $08         ;Flag: Scan for Quote at end of String
    cmp #$22        ;czy to jest cudzysłów
    beq CYTUJ
    bit $0F         ;Flag: DATA scan/List Quote/Garbage collection
    bvs NXLET
    cmp #$3F        ;skrót od PRINT
    bne :+
    lda #$99        ;numer tokena procedury PRINT
    bne NXLET

:   cmp #$30
    bcc :+
    cmp #$3C
    bcc NXLET       ;litery '0' do '9', ':' i ';' zapamietuję w skompilowanym kodzie

:   sty $71         ;Pointer: Used during CRUNCH/ASCII conversion
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
ROZPOZ:
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
    beq :+
    cmp #$49
    bne :++
:   sta $0F         ;Flag: DATA scan/List Quote/Garbage collection
:   sec
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
:   iny
    lda $A09D,y     ;BASIC Command Keyword Table - 1
    bpl :-
    lda $A09E,y     ;BASIC Command Keyword Table
    bne COMP1

    inc $0B         ;Input Buffer Pointer
    bne E8
NTOK:
    inx
E8: iny
NTOK1:
    lda $0200,x     ;BASIC Input Buffer (Input Line from Screen)
    sec
    sbc TOKTB,y
    beq NTOK
    cmp #$80
    beq ROZPOZ

    ldx $7A         ;Pointer: Current Byte of BASIC Text
    inc $0B         ;Input Buffer Pointer
:   iny
    lda TOKTB-1,y
    bpl :-
    lda TOKTB,y
    bne NTOK1
    lda $0200,x     ;BASIC Input Buffer (Input Line from Screen)
    bpl ROZPOZ1

KONIEC:
    sta $01FD,y     ;0 na końcu skompilowanego kodu oraz zresetowanie wskaźnika wejścia na $01ff
    dec $7B         ;Pointer: Current Byte of BASIC Text + 1
    lda #$ff
    sta $7A         ;Pointer: Current Byte of BASIC Text
    rts
.endproc

.segment "RODATA"
TOKTB: .byte "u",'p'+$80       ;token $CD
       .byte "paus",'e'+$80    ;token $CE
       .byte "colou",'r'+$80   ;token $CF
       .byte "hg",'r'+$80      ;token $D0
       .byte "cl",'s'+$80      ;token $D1
       .byte "in",'k'+$80      ;token $D2
       .byte "nr",'m'+$80      ;token $D3
       .byte "plo",'t'+$80     ;token $D4
       .byte "lin",'e'+$80     ;token $D5
       .byte "dra",'w'+$80     ;token $D6
       .byte "shif",'t'+$80    ;token $D7
       .byte "mov",'e'+$80     ;token $D8
       .byte "musi",'c'+$80    ;token $D9
       .byte "voic",'e'+$80    ;token $DA
       .byte "volum",'e'+$80   ;token $DB
       .byte "cl",'i'+$80      ;token $DC
       .byte "shap",'e'+$80    ;token $DD
       .byte "pat",'h'+$80     ;token $DE
       .byte "se",'i'+$80      ;token $DF
       .byte "basi",'c'+$80    ;token $E0
       .byte "tex",'t'+$80     ;token $E1
       .byte "sprit",'e'+$80   ;token $E2
       .byte "scrol",'l'+$80   ;token $E3
       .byte "pla",'y'+$80     ;token $E4
       .byte $00

