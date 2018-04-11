;------------------------------------
; pobiera dwa znaki hex i zwraca jako jeśli napotka przecinek do usuwa adres powrotu i skacze spowrotem do TkVOICE
; mogą wystąpić następujące sytuacje
;   1. skończył się string
;   2. nie ma poprawnej dwucyfrowej liczby hex
;   3. jest poprawna dwucyfrowa liczba hex
;
; używa $02 jak zmienną lokalną
;
; input:
;   Y - numer litery w stringu
;   $BB - wskaźnik do stringu
;   $B7 - długość stringu
; output:
;   A - dwucyfrowa liczba HEX gdy C=0
;   Y - numer litery w stringu
;   $BB - wskaźnik do stringu
;   $B7 - długość stringu
;   C = 1-wystąpił błąd i nie mam wyniku, 0-mam wynik w A
;   X - niezmienione

.export HEX

.segment "CODE"
.proc HEX
    cpy $B7
    bcs koniec_HEX      ;Y jest większe lub równe od długości stringu
    lda ($BB),y
    sec
    sbc #'0'                 ;z '0' zrobi się 0 z 'a' zrobi się 17, z 'f' zrobi się 22
    bcc bledna_cyfra_hex     ;nie jest to cyfra hex
    cmp #10                  ;z 'a' się zrobi 10
    bcc :+
    cmp #17
    bcc bledna_cyfra_hex
    sbc #7
    cmp #16
    bcs koniec_HEX
:   asl
    asl
    asl
    asl
    sta $02

    iny
    cpy $B7
    beq koniec_HEX      ;koniec stringu, C=1 więc nie trzeba ustawiać
    lda ($BB),y
    sec
    sbc #'0'    ;z '0' zrobi się 0 z 'a' zrobi się 17, z 'f' zrobi się 22
    bcc bledna_cyfra_hex     ;nie jest to cyfra hex
    cmp #10      ;z 'a' się zrobi 10
    bcc :+
    cmp #17
    bcc bledna_cyfra_hex
    sbc #7
    cmp #16
    bcs koniec_HEX

:   ora $02
    iny
    clc
    rts

bledna_cyfra_hex:
    sec
koniec_HEX:
    rts
.endproc
