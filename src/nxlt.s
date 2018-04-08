;------------------------------------
; Pobiera parametry dla SCROLL [CONT] "text"[, SSX=1[, SODX=1[, WOL=1]]]
;
; UWAGA modyfikuje DX, które nie jest chronione w przerwaniu
;
; input:
;
; output:
;

.export NXLT, SDX
.import FNDS, KOL, NGAT, SODS, SAD, POS, PM:zeropage, DX:zeropage

.segment "DATA"
SDX:    .byte 1

.segment "CODE"
.proc NXLT
:   ldx KOL
    lda $B000,x
    bne :+
    sta KOL         ;koniec napisu więc KOL=0
    ldy NGAT
    bmi :-          ;najstarszy bit w NGAT oznacza ciągłę zawinięcie napisu
    sta NGAT        ;nie było najstarszego bita więc NGAT=0 czyli koniec przewijania
    rts

:   ldy #0
    sty SAD+1       ;to oznacza, że litera jest narysowana
    cmp #29         ;{CRSR RIGHT}
    bne :+
    inc KOL
    lda $B001,x     ;w A jest odstęp w pikselach
    tax
    jmp :+++

:   ldx SODS
    tay             ;potrzebuję A
    lda DX          ;zachowaj DX
    pha
    tya
    jsr FNDS        ;ustawia DX i PM, wymaga A-numer litery, X-odstęp po literze
    beq :+
    lda PM
    sta SAD         ;SAD wkaźnik na wzorzec litery
    lda PM+1
    sta SAD+1
    lda #1
    sta POS         ;to jest bieżąca pozycja X w literze
:   ldx DX          ;DX ilość wolnych kolumn po literze znalezione przez FNDS
    pla
    sta DX          ;przywróć DX
:   stx SDX         ;SDX podstęp po literze, która będzie właśnie rysowana
    inc KOL
    rts
.endproc
