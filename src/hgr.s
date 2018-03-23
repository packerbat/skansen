;------------------------------------
; przełącza VIC w tryb wysokiej rozdzielczości
; zachowuje flagi, zmienia tylko A

.export HGR

.segment "CODE"
.proc HGR
    php          ;to jest zablokowanie przerwań z zapamiętaniem poprzedniego stanu
    sei
    lda $DD00    ;CIA Data Port A
    and #$fc
    sta $DD00    ;CIA Data Port A, grafika w banku 3
    lda #$48     ;%0100 1000 = video matrix base address 4, character base addres 4 = górne 8 KB bloku 16 KB
    sta $D018    ;VIC Memory Control Register, adres grafiki od $E000 do $FFFF
    lda $D011    ;VIC Control Register 1
    ora #$20     ;Bit 5 = 1 Enable bitmap mode
    sta $D011    ;VIC Control Register 1
    plp
    rts
.endproc
