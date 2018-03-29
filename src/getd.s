;------------------------------------
; pobiera parametry: opcjoanlne współrzędne XC, YC (jeśli jest znak '@'),
;   treść, opcjonalne parametry ROT=0, WOL=0, PTYP=1
; 

.export GETD
.import CXY, WOL, ROT, GETA

.segment "CODE"
.proc GETD
    jsr CXY     ;pobiera tekst do $B7/$BB oraz opcjonalne współrzędne ekranu XC/YC, X=1
    dex
    stx ROT     ; SX=0
    stx WOL     ; WOL=0
    jsr $E206   ;Get Next One Byte Parameter
    jsr $E200   ;Check Default Parameters
    txa
    and #$07
    sta ROT     ;opcjonalny parametr typu BYTE (ale tylko 3 dolne bity) do ROT
    jsr $E206
    jsr $E200
    stx WOL     ;opcjonalny parametr typu BYTE do WOL
    jsr GETA    ;pobiera opcjonaly parametr PTYP
    rts
.endproc
