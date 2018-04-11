;------------------------------------
; obsługa tokena TkPATH definiującego ścieżkę poruszania się sprita
; jest to rodzaj kompilatora, który zamienia ciąg komend podobnych do DRAW
; na blok pamięci w obszarze $A800-$AFFF, bloków może być 8
;
; używa PM, CO, AP, DX - tylko lokalnie
;
; input:
;   BASIC pcode
;   A - byte po tokenie SHAPE
;   Z - 1=koniec
; output:
;

.export TkPATH
.import NUM,GETB, CO:zeropage, PM:zeropage, AP:zeropage, DX:zeropage

.segment "CODE"
.proc TkPATH
    jsr $E211
    jsr GETB        ;ustawia PM ale następna procedura niszczy
    jsr $E254       ;Get Parameters For OPEN/CLOSE

    ldy #0          ;pozycja w bloku
    sty CO          ;Y=0, CO pozycja w bloku
    lda $B7
    beq koniec_PATH     ;string nie może być pusty

:   lda ($BB),y
    sta AP          ;przechowalnia dla komendy, można zastąpić przez stos
    jsr NUM         ;wynik w DX
    lda DX
    bne :+
    inc DX          ;krok nie może być mniejszy niż 1
:   sty CO+1
    ldy CO
    lda AP          ;A=komenda
    sta (PM),y
    iny
    tax             ;X=komenda
    lda DX          ;A=odległość
    cpx #'*'
    bne :+
    clc
    adc #$50        ;'*' ustala adres jednego z 48 kształtów, jakie może przybrać sprite
:   sta (PM),y
    iny
    sty CO
    ldy CO+1
    cpy $B7         ;Y to pozycja w stringu
    bcc :---

koniec_PATH:
    ldy CO
    lda #0
    sta (PM),y      ;dwa zera kończą ścieżkę
    iny
    sta (PM),y
    rts
.endproc

