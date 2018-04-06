;------------------------------------
; pobiera parametry: opcjoanlne współrzędne XC, YC (jeśli jest znak '@'),
;   treść, opcjonalne parametry SX=1, ODS=1, WOL=0, PTYP
; 

.export GETT, SX, ODS, WOL
.import CXY, GETA

.segment "DATA"
SX:    .byte 1
ODS:   .byte 1
WOL:   .byte 0

.segment "CODE"
.proc GETT
    jsr CXY     ;pobiera tekst do $B7/$BB oraz opcjonalne współrzędne ekranu XC/YC, X=1
    stx SX      ; SX=1
    stx ODS     ; ODS=1
    dex
    stx WOL     ; WOL=0
    jsr $E206   ;Get Next One Byte Parameter
    jsr $E200   ;Check Default Parameters
    stx SX      ;opcjonalny parametr typu BYTE do SX
    jsr $E206
    jsr $E200
    stx ODS     ;opcjonalny parametr typu BYTE do ODS
    jsr $E206
    jsr $E200
    stx WOL     ;opcjonalny parametr typu BYTE do WOL
    jsr GETA    ;pobiera opcjonaly parametr PTYP
    rts
.endproc
