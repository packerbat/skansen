;------------------------------------
; Obsługa przerwania
; Mam już zapamiętane wszystkie rejestry na stosie przez KERNAL
; oraz wiem, że nie było to przerwanie spowodowane instrukcją BRK

.export IRQ
.import MIRQ, NIRQ, SIRQ, STPLAY, NGAT, CONT, PM:zeropage

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
    jsr MIRQ

:   jsr SIRQ        ;w środku jest pętla, która sprawdza, który sprite jest włączony a który nie

    lda NGAT        ;NGAT=0 nie ma przewijanego napisu
    beq :+
    dec CONT        ;CONT jest zainicjowane na 1 przez GETS
    bne :+
    lda #$34        ;wyłącza i BASIC i KERNAL
    sta $01
    jsr NIRQ

:   pla
    sta PM+1
    pla
    sta PM
    pla
    sta $01         ;przywraca stan sprzez przerwania
    jmp $EA31       ;wbudowana obsługa przerwania zegarowego
.endproc

