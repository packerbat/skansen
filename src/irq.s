;------------------------------------
; Obsługa przerwania
; Mam już zapamiętane wszystkie rejestry na stosie przez KERNAL
; oraz wiem, że nie było to przerwanie spowodowane instrukcją BRK

.export IRQ
.import MIRQ, STPLAY, PM:zeropage

.segment "CODE"
.proc IRQ
    lda $01
    pha
    lda #$36        ;wyłącza BASIC
    sta $01
    lda PM
    pha
    lda PM+1
    pha

    lda STPLAY      ;STPLAY=0 muzyka wyłączona
    beq :+
    ora #$80
    sta STPLAY      ;najstarszy bit w STPLAY jest semaforem
    jsr MIRQ
    lda STPLAY
    and #$7F
    sta STPLAY

:   ;jsr SIRQ

    lda #$34        ;wyłącza i BASIC i KERNAL
    sta $01
    ;jsr NIRQ

    pla
    sta PM+1
    pla
    sta PM
    pla
    sta $01         ;przywraca stan sprzez przerwania
    jmp $EA31       ;wbudowana obsługa przerwania zegarowego
.endproc

