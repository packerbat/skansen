;------------------------------------
; obsługa tokena VOICE "gen1conf[,gen2conf[,gen3conf]]"
; jego zadaniem jest ustawić parametry 3 generatorów dźwięku z wyjątkiem wysokości dźwięku
; genXconf = AD[SR[FC[0W[WW]]]]
;    A - attack 0..f
;    D - decat 0..f
;    S - sustain 0..f
;    R - release 0..f
;    F - waveform 1-tiangle, 2-sawtooth, 4-pulse, 8-noise
;    C - control register 1-start/stop, 2-synch, 4-ring, 8-test
;    0WWW - pulse width 0000..0fff
;
; używa $D7
;
; input:
;
; output:
;

.export TkVOICE
.import HEX, VOC

.segment "CODE"
.proc TkVOICE
    jsr $E257       ;Get Parameters For OPEN/CLOSE
    ldx #$00
    ldy #$00
:   jsr HEX
    bcs :+
    sta $D405,x     ;set attack and decay
    jsr HEX
    bcs :+
    sta $D406,x     ;set systain and release
    jsr HEX
    bcs :+
    sta $D404,x     ;set control register
    sta VOC,x
    jsr HEX
    bcs :+
    sta $D403,x     ;set pulse waveform width high nybble
    jsr HEX
    bcs :+
    sta $D402,x     ;set pulse waveform width low byte

:   cpy $B7                 ;wiem tylko, że był błąd więc muszę ustalić co się stało
    beq koniec_TkVOICE      ;koniec stringu więc koniec definiowania generatorów
    lda ($BB),y
    cmp #','
    beq :+          ;powodem był przecinek więc idę do następnego generatora
    jmp $B248       ;powodem była zła liczba hex więc błąd "?ILLEGAL QUANTITY"

:   iny             ;pomijam przecinek
    txa
    clc
    adc #$07
    tax
    cpx #21
    bcc :---        ;jeszcze są generatory do zdefiniowania
koniec_TkVOICE:
    rts
.endproc

