;---------------------------------------------------------- 
; sekwencja kopiująca czcionki pod ROM BASIC-a

;---------------------------------------------------------- 
; wzorce czcionek ładowane pod ROM BASIC-a
;    $A000-$A19F - chr$(33)-chr$(63), znaki interpunkcyjne i cyfry
;    $A1A0-$A367 - chr$(65)-chr$(95), małe litery
;    $A368-$A51F - chr$(65+128)-chr$(95+128), wielkie litery
;    $A520-$A6FF - chr$(33+128)-chr$(63+128), polskie znaki
;    $A700-$A7FF - tablica częstotliwości nut

.segment "BINARY"
    .org $A000

;============== znaki interpunkcyjne i cyfry ==============

    .byte 4
    .dbyt %0011111111010000        ;"!"
    .dbyt %0011111111010000

    .byte 12
    .dbyt %0000010000000000        ;"\""
    .dbyt %0011110000000000
    .dbyt %0011100000000000
    .dbyt %0000010000000000
    .dbyt %0011110000000000
    .dbyt %0011100000000000

    .byte 16
    .dbyt %0000010010000000        ;"#"
    .dbyt %0001111111100000
    .dbyt %0001111111100000
    .dbyt %0000010010000000
    .dbyt %0000010010000000
    .dbyt %0001111111100000
    .dbyt %0001111111100000
    .dbyt %0000010010000000

    .byte 16
    .dbyt %0000011001000000        ;"$"
    .dbyt %0000111101100000
    .dbyt %0000100100100000
    .dbyt %0011111111111000
    .dbyt %0011111111111000
    .dbyt %0000100100100000
    .dbyt %0000110111100000
    .dbyt %0000010011000000

    .byte 18
    .dbyt %0001100000110000        ;"%"
    .dbyt %0011110001100000
    .dbyt %0010010011000000
    .dbyt %0011110110000000
    .dbyt %0001101101100000
    .dbyt %0000011011110000
    .dbyt %0000110010010000
    .dbyt %0001100011110000
    .dbyt %0011000001100000

    .byte 18
    .dbyt %0000000011100000        ;"&"
    .dbyt %0001100111110000
    .dbyt %0011111100010000
    .dbyt %0010011000010000
    .dbyt %0011111100110000
    .dbyt %0001100111100000
    .dbyt %0000000011100000
    .dbyt %0000000110110000
    .dbyt %0000000100010000

    .byte 6
    .dbyt %0000010000000000        ;"'"
    .dbyt %0011110000000000
    .dbyt %0011100000000000

    .byte 8
    .dbyt %0000111111000000        ;"("
    .dbyt %0001111111100000
    .dbyt %0011000000110000
    .dbyt %0010000000010000

    .byte 8
    .dbyt %0010000000010000        ;")"
    .dbyt %0011000000110000
    .dbyt %0001111111100000
    .dbyt %0000111111000000

    .byte 18
    .dbyt %0000000100000000        ;"*"
    .dbyt %0000100100100000
    .dbyt %0000110101100000
    .dbyt %0000011111000000
    .dbyt %0000001110000000
    .dbyt %0000011111000000
    .dbyt %0000110101100000
    .dbyt %0000100100100000
    .dbyt %0000000100000000

    .byte 16
    .dbyt %0000000100000000        ;"+"
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000111111100000
    .dbyt %0000111111100000
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000000100000000

    .byte 6
    .dbyt %0000000000000100        ;","
    .dbyt %0000000000111100
    .dbyt %0000000000111000

    .byte 16
    .dbyt %0000000100000000        ;"-"
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000000100000000

    .byte 4
    .dbyt %0000000000110000        ;"."
    .dbyt %0000000000110000

    .byte 18
    .dbyt %0000000000100000
    .dbyt %0000000001100000        ;"/"
    .dbyt %0000000011000000
    .dbyt %0000000110000000
    .dbyt %0000001100000000
    .dbyt %0000011000000000
    .dbyt %0000110000000000
    .dbyt %0001100000000000
    .dbyt %0001000000000000

    .byte 14
    .dbyt %0001111111100000        ;"0"
    .dbyt %0011111111110000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0011111111110000
    .dbyt %0001111111100000

    .byte 12
    .dbyt %0000100000010000        ;"1"
    .dbyt %0001100000010000
    .dbyt %0011111111110000
    .dbyt %0011111111110000
    .dbyt %0000000000010000
    .dbyt %0000000000010000

    .byte 14
    .dbyt %0001000000110000        ;"2"
    .dbyt %0011000001110000
    .dbyt %0010000011010000
    .dbyt %0010000110010000
    .dbyt %0010001100010000
    .dbyt %0011111000010000
    .dbyt %0001110000010000

    .byte 14
    .dbyt %0001000000100000        ;"3"
    .dbyt %0011000000110000
    .dbyt %0010000000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0011111111110000
    .dbyt %0001110111100000

    .byte 16
    .dbyt %0000000110000000        ;"4"
    .dbyt %0000001110000000
    .dbyt %0000011010000000
    .dbyt %0000110010000000
    .dbyt %0001100010000000
    .dbyt %0011111111110000
    .dbyt %0011111111110000
    .dbyt %0000000010000000

    .byte 14
    .dbyt %0011111000100000        ;"5"
    .dbyt %0011111000110000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001111110000
    .dbyt %0000000111100000

    .byte 14
    .dbyt %0000111111100000        ;"6"
    .dbyt %0001111111110000
    .dbyt %0011001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001111110000
    .dbyt %0000000111100000

    .byte 14
    .dbyt %0011000000000000        ;"7"
    .dbyt %0011000000000000
    .dbyt %0010000111110000
    .dbyt %0010001111110000
    .dbyt %0010011000000000
    .dbyt %0011110000000000
    .dbyt %0011100000000000

    .byte 14
    .dbyt %0001110111100000        ;"8"
    .dbyt %0011111111110000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0011111111110000
    .dbyt %0001110111100000

    .byte 14
    .dbyt %0001111000000000        ;"9"
    .dbyt %0011111100010000
    .dbyt %0010000100010000
    .dbyt %0010000100010000
    .dbyt %0010000100110000
    .dbyt %0011111111100000
    .dbyt %0001111111000000

    .byte 4
    .dbyt %0000011001100000        ;":"
    .dbyt %0000011001100000

    .byte 6
    .dbyt %0000000000001000        ;";"
    .dbyt %0000011001111000
    .dbyt %0000011001110000

    .byte 12
    .dbyt %0000000100000000        ;"<"
    .dbyt %0000001110000000
    .dbyt %0000011011000000
    .dbyt %0000110001100000
    .dbyt %0001100000110000
    .dbyt %0001000000010000

    .byte 12
    .dbyt %0000001010000000        ;"="
    .dbyt %0000001010000000
    .dbyt %0000001010000000
    .dbyt %0000001010000000
    .dbyt %0000001010000000
    .dbyt %0000001010000000

    .byte 12
    .dbyt %0001000000010000        ;">"
    .dbyt %0001100000110000
    .dbyt %0000110001100000
    .dbyt %0000011011000000
    .dbyt %0000001110000000
    .dbyt %0000000100000000

    .byte 14
    .dbyt %0001000000000000        ;"?"
    .dbyt %0011000000000000
    .dbyt %0010000011010000
    .dbyt %0010000111010000
    .dbyt %0010001100000000
    .dbyt %0011111000000000
    .dbyt %0001110000000000

    .res $A1A0-*,0

;============== małe litery ==============

    .byte 16
    .dbyt %0000000011100000        ;"a"
    .dbyt %0000010111110000
    .dbyt %0000010100010000
    .dbyt %0000010100010000
    .dbyt %0000010100010000
    .dbyt %0000011111100000
    .dbyt %0000001111110000
    .dbyt %0000000000010000

    .byte 14
    .dbyt %0011111111110000        ;"d"
    .dbyt %0011111111110000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000011111110000
    .dbyt %0000001111100000

    .byte 14
    .dbyt %0000001111100000        ;"c"
    .dbyt %0000011111110000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000011000110000
    .dbyt %0000001000100000

    .byte 14
    .dbyt %0000001111100000        ;"d"
    .dbyt %0000011111110000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0011111111110000
    .dbyt %0011111111110000

    .byte 14
    .dbyt %0000001111100000        ;"e"
    .dbyt %0000011111110000
    .dbyt %0000010010010000
    .dbyt %0000010010010000
    .dbyt %0000010010010000
    .dbyt %0000011110110000
    .dbyt %0000001110100000

    .byte 10
    .dbyt %0000001000000000
    .dbyt %0001111111110000        ;"f"
    .dbyt %0011111111110000
    .dbyt %0010001000000000
    .dbyt %0010001000000000

    .byte 14
    .dbyt %0000001100011100
    .dbyt %0000011110111110        ;"g"
    .dbyt %0000010011110010
    .dbyt %0000010011010010
    .dbyt %0000010010010010
    .dbyt %0000011110011110
    .dbyt %0000001100001100

    .byte 14
    .dbyt %0011111111110000        ;"h"
    .dbyt %0011111111110000
    .dbyt %0000001000000000
    .dbyt %0000010000000000
    .dbyt %0000010000000000
    .dbyt %0000011111110000
    .dbyt %0000001111110000

    .byte 8
    .dbyt %0000010000010000        ;"i"
    .dbyt %0011011111110000
    .dbyt %0011011111110000
    .dbyt %0000000000010000

    .byte 8
    .dbyt %0000010000000010        ;"j"
    .dbyt %0000010000000110
    .dbyt %0011011111111100
    .dbyt %0011011111111000

    .byte 14
    .dbyt %0011111111110000        ;"k"
    .dbyt %0011111111110000
    .dbyt %0000000110000000
    .dbyt %0000001111000000
    .dbyt %0000011001100000
    .dbyt %0000110000110000
    .dbyt %0000100000010000

    .byte 8
    .dbyt %0010000000010000        ;"l"
    .dbyt %0011111111110000
    .dbyt %0011111111110000
    .dbyt %0000000000010000

    .byte 20
    .dbyt %0000011111110000        ;"m"
    .dbyt %0000011111110000
    .dbyt %0000001000000000
    .dbyt %0000010000000000
    .dbyt %0000011111110000
    .dbyt %0000001111110000
    .dbyt %0000001000000000
    .dbyt %0000010000000000
    .dbyt %0000011111110000
    .dbyt %0000001111110000

    .byte 14
    .dbyt %0000011111110000        ;"n"
    .dbyt %0000011111110000
    .dbyt %0000001000000000
    .dbyt %0000010000000000
    .dbyt %0000010000000000
    .dbyt %0000011111110000
    .dbyt %0000001111110000

    .byte 14
    .dbyt %0000001111100000        ;"o"
    .dbyt %0000011111110000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000011111110000
    .dbyt %0000001111100000

    .byte 14
    .dbyt %0000011111111110        ;"p"
    .dbyt %0000011111111110
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000011111110000
    .dbyt %0000001111100000

    .byte 14
    .dbyt %0000001111100000        ;"q"
    .dbyt %0000011111110000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000010000010000
    .dbyt %0000011111111110
    .dbyt %0000011111111110

    .byte 12
    .dbyt %0000011111110000        ;"r"
    .dbyt %0000011111110000
    .dbyt %0000001100000000
    .dbyt %0000011000000000
    .dbyt %0000010000000000
    .dbyt %0000010000000000

    .byte 14
    .dbyt %0000001100100000        ;"s"
    .dbyt %0000011110110000
    .dbyt %0000010010010000
    .dbyt %0000010010010000
    .dbyt %0000010010010000
    .dbyt %0000011011110000
    .dbyt %0000001001100000

    .byte 10
    .dbyt %0000010000000000        ;"t"
    .dbyt %0011111111100000
    .dbyt %0011111111110000
    .dbyt %0000010000010000
    .dbyt %0000010000010000

    .byte 14
    .dbyt %0000011111100000        ;"u"
    .dbyt %0000011111110000
    .dbyt %0000000000010000
    .dbyt %0000000000010000
    .dbyt %0000000000100000
    .dbyt %0000011111110000
    .dbyt %0000011111110000

    .byte 14
    .dbyt %0000011110000000        ;"v"
    .dbyt %0000011111000000
    .dbyt %0000000001100000
    .dbyt %0000000000010000
    .dbyt %0000000001100000
    .dbyt %0000011111000000
    .dbyt %0000011110000000

    .byte 18
    .dbyt %0000011111100000        ;"w"
    .dbyt %0000011111110000
    .dbyt %0000000000110000
    .dbyt %0000000001100000
    .dbyt %0000000011100000
    .dbyt %0000000001100000
    .dbyt %0000000000110000
    .dbyt %0000011111110000
    .dbyt %0000011111100000

    .byte 16
    .dbyt %0000010000010000        ;"x"
    .dbyt %0000011000110000
    .dbyt %0000001101100000
    .dbyt %0000000111000000
    .dbyt %0000000111000000
    .dbyt %0000001101100000
    .dbyt %0000011000110000
    .dbyt %0000010000010000

    .byte 14
    .dbyt %0000011111100000        ;"y"
    .dbyt %0000011111110010
    .dbyt %0000000000010010
    .dbyt %0000000000010010
    .dbyt %0000000000100110
    .dbyt %0000011111111100
    .dbyt %0000011111111000

    .byte 14
    .dbyt %0000010000110000        ;"z"
    .dbyt %0000010001110000
    .dbyt %0000010011010000
    .dbyt %0000010110010000
    .dbyt %0000011100010000
    .dbyt %0000011000010000
    .dbyt %0000010000010000

    .byte 10
    .dbyt %0011111111110000        ;"["
    .dbyt %0011111111110000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0010000000010000

    .byte 14
    .dbyt %0000001000110000        ;"{funt}"
    .dbyt %0000111111110000
    .dbyt %0000111111010000
    .dbyt %0001101000010000
    .dbyt %0010001000010000
    .dbyt %0011000000010000
    .dbyt %0001000000110000

    .byte 10
    .dbyt %0010000000010000        ;"]"
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0011111111110000
    .dbyt %0011111111110000

    .byte 16
    .dbyt %0000011000000000        ;"{up}"
    .dbyt %0000110000000000
    .dbyt %0001100000000000
    .dbyt %0011111111110000
    .dbyt %0011111111110000
    .dbyt %0001100000000000
    .dbyt %0000110000000000
    .dbyt %0000011000000000

    .byte 16
    .dbyt %0000000100000000        ;"{left}"
    .dbyt %0000001110000000
    .dbyt %0000011111000000
    .dbyt %0000110101100000
    .dbyt %0000100100100000
    .dbyt %0000000100000000
    .dbyt %0000000100000000
    .dbyt %0000000100000000

    .res $A368-*,0

;============== wielkie litery ==============

    .byte 16
    .dbyt %0000111111110000        ;"A"
    .dbyt %0001111111110000
    .dbyt %0011000100000000
    .dbyt %0010000100000000
    .dbyt %0010000100000000
    .dbyt %0011000100000000
    .dbyt %0001111111110000
    .dbyt %0000111111110000

    .byte 16
    .dbyt %0011111111110000        ;"B"
    .dbyt %0011111111110000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0011111111110000
    .dbyt %0001110111100000

    .byte 16
    .dbyt %0000111111000000        ;"C"
    .dbyt %0001111111100000
    .dbyt %0011000000110000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0011000000110000
    .dbyt %0001000000100000

    .byte 16
    .dbyt %0011111111110000        ;"D"
    .dbyt %0011111111110000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0011000000110000
    .dbyt %0001111111100000
    .dbyt %0000111111000000

    .byte 14
    .dbyt %0011111111110000        ;"E"
    .dbyt %0011111111110000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010000000010000

    .byte 14
    .dbyt %0011111111110000        ;"F"
    .dbyt %0011111111110000
    .dbyt %0010001000000000
    .dbyt %0010001000000000
    .dbyt %0010001000000000
    .dbyt %0010001000000000
    .dbyt %0010000000000000

    .byte 16
    .dbyt %0000111111000000        ;"G"
    .dbyt %0001111111100000
    .dbyt %0011000000110000
    .dbyt %0010000000010000
    .dbyt %0010001000010000
    .dbyt %0010001000100000
    .dbyt %0011001111110000
    .dbyt %0001001111110000

    .byte 16
    .dbyt %0011111111110000        ;"H"
    .dbyt %0011111111110000
    .dbyt %0000001000000000
    .dbyt %0000001000000000
    .dbyt %0000001000000000
    .dbyt %0000001000000000
    .dbyt %0011111111110000
    .dbyt %0011111111110000

    .byte 8
    .dbyt %0010000000010000        ;"I"
    .dbyt %0011111111110000
    .dbyt %0011111111110000
    .dbyt %0010000000010000

    .byte 12
    .dbyt %0010000000100000        ;"J"
    .dbyt %0010000000110000
    .dbyt %0010000000010000
    .dbyt %0010000000110000
    .dbyt %0011111111100000
    .dbyt %0011111111000000

    .byte 16
    .dbyt %0011111111110000        ;"K"
    .dbyt %0011111111110000
    .dbyt %0000001100000000
    .dbyt %0000011110000000
    .dbyt %0000110011000000
    .dbyt %0001100001100000
    .dbyt %0011000000110000
    .dbyt %0010000000010000

    .byte 12
    .dbyt %0011111111110000        ;"L"
    .dbyt %0011111111110000
    .dbyt %0000000000010000
    .dbyt %0000000000010000
    .dbyt %0000000000010000
    .dbyt %0000000000010000

    .byte 18
    .dbyt %0011111111110000        ;"M"
    .dbyt %0001111111110000
    .dbyt %0000110000000000
    .dbyt %0000011000000000
    .dbyt %0000001100000000
    .dbyt %0000011000000000
    .dbyt %0000110000000000
    .dbyt %0001111111110000
    .dbyt %0011111111110000

    .byte 16
    .dbyt %0011111111110000        ;"N"
    .dbyt %0011111111110000
    .dbyt %0000111000000000
    .dbyt %0000011100000000
    .dbyt %0000001110000000
    .dbyt %0000000111000000
    .dbyt %0011111111110000
    .dbyt %0011111111110000

    .byte 16
    .dbyt %0000111111000000        ;"O"
    .dbyt %0001111111100000
    .dbyt %0011000000110000
    .dbyt %0010000000010000
    .dbyt %0010000000010000
    .dbyt %0011000000110000
    .dbyt %0001111111100000
    .dbyt %0000111111000000

    .byte 16
    .dbyt %0011111111110000        ;"P"
    .dbyt %0011111111110000
    .dbyt %0010000100000000
    .dbyt %0010000100000000
    .dbyt %0010000100000000
    .dbyt %0010000100000000
    .dbyt %0011111100000000
    .dbyt %0001111000000000

    .byte 18
    .dbyt %0000111111000000        ;"Q"
    .dbyt %0001111111100000
    .dbyt %0011000000110000
    .dbyt %0010000000010000
    .dbyt %0010000001010000
    .dbyt %0011000001110000
    .dbyt %0001111111100000
    .dbyt %0000111111110000
    .dbyt %0000000000010000

    .byte 16
    .dbyt %0011111111110000        ;"R"
    .dbyt %0011111111110000
    .dbyt %0010000100000000
    .dbyt %0010000110000000
    .dbyt %0010000111000000
    .dbyt %0010000101100000
    .dbyt %0011111100110000
    .dbyt %0001111000010000

    .byte 16
    .dbyt %0001110000100000        ;"S"
    .dbyt %0011111000110000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0010001000010000
    .dbyt %0011001111110000
    .dbyt %0001000111100000

    .byte 16
    .dbyt %0010000000000000        ;"T"
    .dbyt %0010000000000000
    .dbyt %0010000000000000
    .dbyt %0011111111110000
    .dbyt %0011111111110000
    .dbyt %0010000000000000
    .dbyt %0010000000000000
    .dbyt %0010000000000000

    .byte 16
    .dbyt %0011111111100000        ;"U"
    .dbyt %0011111111110000
    .dbyt %0000000000010000
    .dbyt %0000000000010000
    .dbyt %0000000000010000
    .dbyt %0000000000010000
    .dbyt %0011111111110000
    .dbyt %0011111111100000

    .byte 16
    .dbyt %0011111110000000        ;"U"
    .dbyt %0011111111000000
    .dbyt %0000000001100000
    .dbyt %0000000000110000
    .dbyt %0000000000110000
    .dbyt %0000000001100000
    .dbyt %0011111111000000
    .dbyt %0011111110000000

    .byte 18
    .dbyt %0011111111110000        ;"W"
    .dbyt %0011111111100000
    .dbyt %0000000011000000
    .dbyt %0000000110000000
    .dbyt %0000001100000000
    .dbyt %0000000110000000
    .dbyt %0000000011000000
    .dbyt %0011111111100000
    .dbyt %0011111111110000

    .byte 18
    .dbyt %0011000000110000        ;"X"
    .dbyt %0011100001110000
    .dbyt %0000110011000000
    .dbyt %0000011110000000
    .dbyt %0000001100000000
    .dbyt %0000011110000000
    .dbyt %0000110011000000
    .dbyt %0011100001110000
    .dbyt %0011000000110000

    .byte 16
    .dbyt %0011100000000000        ;"Y"
    .dbyt %0011110000000000
    .dbyt %0000011000000000
    .dbyt %0000001111110000
    .dbyt %0000001111110000
    .dbyt %0000011000000000
    .dbyt %0011110000000000
    .dbyt %0011100000000000

    .byte 16
    .dbyt %0010000001110000        ;"Z"
    .dbyt %0010000011110000
    .dbyt %0010000110010000
    .dbyt %0010001100010000
    .dbyt %0010011000010000
    .dbyt %0010110000010000
    .dbyt %0011100000010000
    .dbyt %0011000000010000

    .byte 0                        ;" "

    .byte 0                        ;" "

    .byte 0                        ;" "

    .byte 0                        ;" "

    .byte 0                        ;" "

    .res $A520-*,0

;============== polskie litery ==============

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .byte 4
    .dbyt %0000000000110000        ;" "
    .dbyt %0000000000110000

    .res $A700-*,0

;============== wysokości nut ==============

    .word 1*256+12
    .word 1*256+28
    .word 1*256+45
    .word 1*256+62
    .word 1*256+81
    .word 1*256+102
    .word 1*256+123
    .word 1*256+145
    .word 1*256+169
    .word 1*256+195
    .word 1*256+221
    .word 1*256+250
    .word 2*256+24
    .word 2*256+56
    .word 2*256+90
    .word 2*256+124
    .word 2*256+163
    .word 2*256+204
    .word 2*256+246
    .word 3*256+35
    .word 3*256+83
    .word 3*256+134
    .word 3*256+187
    .word 3*256+244
    .word 4*256+48
    .word 4*256+112
    .word 4*256+180
    .word 4*256+251
    .word 5*256+71
    .word 5*256+152
    .word 5*256+237
    .word 6*256+71
    .word 6*256+167
    .word 7*256+12
    .word 7*256+119
    .word 7*256+233
    .word 8*256+97
    .word 8*256+225
    .word 9*256+104
    .word 9*256+247
    .word 10*256+143
    .word 11*256+48
    .word 11*256+218
    .word 12*256+143
    .word 13*256+78
    .word 14*256+24
    .word 14*256+239
    .word 15*256+210
    .word 16*256+195
    .word 17*256+195
    .word 18*256+209
    .word 19*256+239
    .word 21*256+31
    .word 22*256+96
    .word 23*256+181
    .word 25*256+30
    .word 26*256+156
    .word 28*256+49
    .word 29*256+223
    .word 31*256+165
    .word 33*256+135
    .word 35*256+134
    .word 37*256+162
    .word 39*256+223
    .word 42*256+62
    .word 44*256+193
    .word 47*256+107
    .word 50*256+60
    .word 53*256+57
    .word 56*256+99
    .word 59*256+190
    .word 63*256+75
    .word 67*256+15
    .word 71*256+12
    .word 75*256+69
    .word 79*256+191
    .word 84*256+125
    .word 89*256+131
    .word 94*256+214
    .word 100*256+121
    .word 106*256+115
    .word 112*256+199
    .word 119*256+124
    .word 126*256+151
    .word 134*256+30
    .word 142*256+24
    .word 150*256+139
    .word 159*256+126
    .word 168*256+250
    .word 179*256+6
    .word 189*256+172
    .word 200*256+143
    .word 212*256+230
    .word 225*256+143
    .word 238*256+248
    .word 253*256+46

    .res $A800-*,0
