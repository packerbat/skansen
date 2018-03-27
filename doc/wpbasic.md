# WORDPROCESSOR BASIC

## Uruchamianie

Niestety nie pamiętam, dlaczego to rozszerzenie BASIC-a nazywa się WORDPROCESSOR BASIC, ale tak
go nazwałem i na razie zachowuję tę nazwę. Program ładujemy standardową procedurą:

    LOAD "WPBASIC",8

a po załadowaniu, uruchamiamy poleceniem:

    RUN

## Nowe komendy BASIC-a

### HGR

Komenda HGR służy do przełączania układu VIC-II w tryb graficzny wysokiej rozdzielczości (320 &times; 200).
Składnia:

    HGR [<kolor piksela> [, <kolor tła> [, <kolor ramki>]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.

### INK

Komenda INK służy do ustawienia 3 kolorów - piksea, tła i ramki. Składnia:

    INK [<kolor piksela> [, <kolor tła> [, <kolor ramki>]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.
Akurat dla tej komendy pominięcie wszystkich kolorów nie ma większego sensu.

### CLS

Komenda CLS służy do wyczyszczenia ekranu w trybie graficznym. Składnia:

    CLS [<kolor piksela> [, <kolor tła> [, <kolor ramki>]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.

### NRM

Komenda NRM służy do przełączania układu VIC-II w tryb tekstowy (40 &times; 25).
Składnia:

    NRM [<kolor litery> [, <kolor tła> [, <kolor ramki>]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.

### COLOUR

Komenda COLOUR służy do zmiany kolorów w trybie tekstowym. Składnia:

    COLOUR [<kolor litery> [, <kolor tła> [, <kolor ramki>]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.
Tu także pominięcie wszystkich kolorów nie ma większego sensu.

### PAUSE

Komenda PAUSE służy do zatrzymania programu aż do wciśnięcia dowolnego klawisza. Opcjonalnie
można podać czas, po którym PAUSE się za zakończy nawet jeśli użytkownik nic nie wciśnie. Składnia:

    PAUSE [<czas w 1/60 sekundy>]

Czas podawany jest jednostkach 1/60 sekundy bo mniej więcej 60 razy na sekundę jest zwiększany
licznik czasu rzeczywistego (*jiffy clock*). Za aktualizowanie tego czasu jest odpowiedzialna procedura
przerwań IRQ generowanych przez Timer A układu CIA #1. Ten zegar nie jest zbyt dokładny, w dodatku
zegar nie jest zwiększany gdy przerwania są zamaskowane. Procedura jest mocno  uproszczona i np. nie 
przewiduje zawinięcia się zegara przy zmianie doby.

**Przykład 1, przełączanie trybów**

Poniższy program przełączy się w tryb graficzny, wyczyści ekran, poczeka 10 sekund i wróci do trybu
tekstowego.

    10 hgr 1,0,0
    20 cls
    30 pause 600
    40 nrm 1,6,3
    run

Kolory w tym przykładzie to 1 = biały, 0 = czarny, 6 = niebieski, 3 = seledynowy

### PLOT

Komenda PLOT służy do zmiany stanu piksela w trybie wysokiej rozdzielczości. Składnia:

    PLOT x, y [, <sposób-zmiany>]

Współrzędna *x* to numer kolumny w zakresie 0 do 319 licząc od lewej do prawej, a współrzędna *y* to
numer wiersza w zakresie 0 do 199 licząc od góry do dołu. Obie wartości mogą być rzeczywiste. Opcjonalny
parametr *sposób-zmian* może mieć jedną z 3 wartości: 0 - wartość piksela będzie 0, 1 - wartość piksela
będzie 1, 2 - wartość piksela zostanie zanegowana.

**Przykład 2, wykres punktowy**

Poniższy program przełączy się w tryb graficzny, wyczyści ekran, i narysuje wykres funkcji sin(x) rozciągnięty
na cały obszar ekranu. Po narysowaniu wykresu program będzie czekał na wciśnięcie dowolnego klawisza a gdy to
nastąpi, wróci do trybu tekstowego.

    10 hgr 1,0
    20 cls
    30 for i=0 to 319
    40 plot i,100-100*sin(0.1*i),1
    50 next
    60 pause
    70 nrm
    run

Wykres będzie się składał z białych pikseli na czarnym tle a ramka będzie miała niezmieniony kolor.

