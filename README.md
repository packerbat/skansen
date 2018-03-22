# Przewodnik po skansenie w Ciechanowcu

## Rys historyczny

Program powstał w 1987 roku na komputerze Commodore 64. Komputera już dawno nie mam bo mniej więcej
w tym czasie kupiłem pierwszy komputer klasy IBM PC (Inswell XT 4,7 MHz sprowadzony bezpośrednio z Tajwanu)
i całkowicie przesiadłem się na PC-ty z systemem DOS. W tedy tego nie wiedziałem ale przesiadłem się [z 
softwaru Microsoftu na software Microsoftu](https://www.c64-wiki.com/wiki/Microsoft).

Jedyne co mi pozostało po tym programie to bardzo długi wydruk obu jego części:

1. rozszerzenie BASIC-a napisanego w asemblerze 6510,
2. przewodnik po skansenie napisany w BASIC-u.

Commoodre 64 był na swoje czasy genialnym komputerem za relatywnie niewielkie pieniądze,
jednak jego interpreter BASIC-a zajmujący około 9KB był mocno okrojony. Nie miał ani komend
do przełączania się w tryb graficzny, nie obsługiwał spritów, nie pozwalał odtwarzać muzyki we wbudowanym
syntezatorze SID. Do wszystkich bardziej zaawansowanych rzeczy trzeba było używać PEEK/POKE. Obsługa
przerwań IRQ i NMI nie była możliwa w BASIC-u.

## Ocalić od zapomnienia

O dziwo świat nie zapomniał o architekturze 6502/6510/65C10. Jest bardzo wiele serwisów poświęconych tej rodzinie 
procesorów i komputerom zbudowanych na bazie tego procesora. Nie mówiąc już o tym, że jest wiele egzemplarzy Commodore 
64, które działają do dziś. Wciąż powstają gry na C64 np. [Planet X2](https://www.youtube.com/watch?v=NB_VBl7ut9Y).

Impulsem do odtworzenia mojego oprogramowania były 4 strony:

1. niezwykle rozbudowana i szczegółowa strona o [firmwarze C64](http://unusedino.de/ec64/technical/aay/c64/),
2. niezwykły emulator [VICE](http://vice-emu.sourceforge.net/),
3. fantastyczny kroskompilator [cc65](https://www.cc65.org/),
4. rozszerzenie BASIC-a o nazwie [Cypherbasic](https://github.com/silizium/cypherbasic) pana Hanno Behrens z Niemiec.

Pisząc przewodnik po skansenie w Ciechanowcu w 1987 bazowałem na swoich wcześniejszych programach i na podręczniku
"Programmer's Reference Guide" z 1983 roku wydanym przez CBM. Pisanie tak dużych programów bezpośrednio na C64 było 
niezwykle czasochłonne i niewygodne. Dziś nie odbiega to od pisania programów na "duże" komputery:

1. edycja w ulubionym edytorze (czyli [Komodo Edit](https://www.activestate.com/komodo-edit)),
2. kompilacja relokowalnych obiektów (`ca65`),
3. tworzenie bibliotek obiektów (`ar65`),
4. konsolidacja pliku wykonywalnego z relokacją (`ld65`),
5. stworzenie obrazu dyskietki (`c1561`).

A wszystko etapy tworzenia programu są kontrolowane przez program *make*. Gdybym ja miał takie możliwości 
w latach 1983-1987!

## Kompilacja

Kompilacja sprowadza się do wydania jednego polecenia:

make

W wyniku kompilacji powstaje program `wpbasic.prg` obraz dyskietki `skansen.d64`, który zawiera na razie
jeden pliki czyli `wpbasic.prg`

## Uruchamianie

Klasyczne uruchomienie to:

1. uruchomienie emulatora VICE (`x64`),
2. podłączenie obrazu dyskietki `skansen.d64` do napędu 8,
3. wczytanie rozszerzenia BASIC-a poleceniem: `LOAD "WPBASIC",8`,
4. uruchomienie rozszerzenia BASIC-a poleceniem: `RUN`

W następnych punktach będzie wczytanie i uruchomienie części przewodnika napisanej w BASIC-u,
ale jeszcze jej nie ma.

Aby przetestować sam WPBASIC można te wszystkie czynności skrócić do jednego polecenia:

```
>x64 -autostart wpbasic.prg
```


UWAGA: To są dopiero fragmenty części asemblerowej. Kolejne moduły będę zamieszczał w miarę wolnego czasu.

Michał Wilde

