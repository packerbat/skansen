;------------------------------------
; przywrócenie trybu tekstowego przy zablokowanych przerwaniach
; zachowuje flagi, zmienia tylko A

.export NRM

.segment "CODE"
.proc NRM
    php
    sei
    lda $D011    ;VIC Control Register 1
    and #$df     ;Bit 5 = 0 Disable bitmap mode
    sta $D011    ;VIC Control Register 1
    lda #$16     ;%0001 0110 = video matrix base address 1, character base addres 3 to ROM z małymi literami
    sta $D018    ;VIC Memory Control Register, adres grafiki od $0400 do $07FF
    lda $DD00    ;CIA Data Port A
    ora #$03
    sta $DD00    ;CIA Data Port A, grafika w banku 0
    plp
    rts
.endproc