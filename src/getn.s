;------------------------------------
; interpretuje string ($BB) od długości w $B7 jako nuty
; po '*' oczekuje HEX, zamienia na <#ff><hex>, to jest komenda zmieniająca Control Register, równoważne !04<hex>
; po '!' oczekuje HEX1 i HEX2, zamienia na <hex1+128><hex2>, ta komenda zmienia dowolny rejestr podany nako HEX1 na wartość HEX2
; po '.' oczekuje DEC a jeśli nie ma to bierze czas z poprzedniej nuty, kropka to pauza bo nuta ma wartość 1 <#1><dlugosc>
; po nucie może być 1 cyfra oktawy i czas trwania DEC <nuta+1><dlugosc>
;
; CO+1 - bieżąca oktawa jeśli nie jest podana w nucie
;
; input:
;   Y - znak do analizy nuty
; output:
;   Y - następny znak do analizy nuty
;   AP - 16-bitowa definicja nuty

.export GETN, AP
.import NUTA, GETL, NUM, HEX, CO:zeropage, DX:zeropage

.segment "FPAC1": zeropage
AP:   .res 2

.segment "CODE"
.proc GETN
    lda ($BB),y
    ldx #0
    cmp #'.'
    beq E37
    cmp #'!'
    beq E38
    cmp #'*'
    beq E80
    jsr NUTA        ;w X mamy liczbę 0-13, np nuta C to 1, Cis to 2
    stx CO          ;CO przechowalnia znalezionej nuty
    jsr GETL        ;w A zwraca liczbę 0..9 gdy C=0, C=1 oznacza błąd
    bcs E36
    cmp #8
    bcs E40         ;maksymalnie do c7
    sta $02
    asl
    adc $02
    asl
    asl
    sta CO+1        ;numer oktawy*12
    iny
E36:
    dey             ;to nie była cyfra 0..9 więc jako oktawę przyjmuję CO+1
    lda CO+1
    clc
    adc CO
    tax             ;w X mam nutę z uwzględnioną oktawą
E37:
    inx         ;nuta jest '.'
    stx AP      ;do AP idzie wysokość nuty + 1
    jsr NUM     ;teraz czytam dziesiętną liczbę 8-bitową, wynik jest w DX
    lda DX      ;DX=0 nie jest błędem, poprostu nie ma czasu trwania nuty bo jest on taki sam jak nuty wcześniejszej
    beq :+
    sta AP+1    ;czas trwania nuty
:   rts

E40:
    jmp $B248       ;?ILLEGAL QUANTITY

E38:
    iny         ;nuta jest '!'
    jsr HEX
    ora #$80
    bne E81     ;skok bezwarunkowy

E80:
    iny         ;nuta jest '*'
    lda #$84    ;Numer rejestru VOC

E81:
    sta AP
    jsr HEX
    sta AP+1
    rts

.endproc
