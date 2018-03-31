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

    HGR [fgcolor [, bgcolor [, framecolor]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.

### INK

Komenda INK służy do ustawienia 3 kolorów - piksea, tła i ramki. Składnia:

    INK [fgcolor [, bgcolor [, framecolor]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.
Akurat dla tej komendy pominięcie wszystkich kolorów nie ma większego sensu.

### CLS

Komenda CLS służy do wyczyszczenia ekranu w trybie graficznym. Składnia:

    CLS [fgcolor [, bgcolor [, framecolor]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.

### NRM

Komenda NRM służy do przełączania układu VIC-II w tryb tekstowy (40 &times; 25).
Składnia:

    NRM [<kolor litery> [, bgcolor [, framecolor]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.

### COLOUR

Komenda COLOUR służy do zmiany kolorów w trybie tekstowym. Składnia:

    COLOUR [chrcolor [, bgcolor [, framecolor]]]

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

    PLOT x, y [, drawmode]

Współrzędna *x* to numer kolumny w zakresie 0 do 319 licząc od lewej do prawej, a współrzędna *y* to
numer wiersza w zakresie 0 do 199 licząc od góry do dołu. Obie wartości mogą być rzeczywiste. Opcjonalny
parametr *drawmode* może mieć jedną z 3 wartości: 0 - wartość piksela będzie 0, 1 - wartość piksela
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

### LINE

Komenda LINE służy do rysowania odcinków o podanych współrzędnych początku i końca odcinka. Składnia:

    LINE TO x2, y2 [, drawmode]
    
albo

    LINE x1, y1, x2, y2 [, drawmode]

Współrzędne *x1* i *x2* to numery kolumn w zakresie 0 do 319 licząc od lewej do prawej, a współrzędne *y1* i *y2* to
numery wierszy w zakresie 0 do 199 licząc od góry do dołu. Każda z czterech wartości może być rzeczywista. Opcjonalny
parametr *drawmode* może mieć jedną z 3 wartości: 0 - wartość piksela będzie 0, 1 - wartość piksela
będzie 1, 2 - wartość piksela zostanie zanegowana.

**Przykład 3, wykres odcinkowy**

Poniższy program przełączy się w tryb graficzny, wyczyści ekran i narysuje wykres funkcji sin(x)/x rozciągnięty
na cały obszar ekranu. Po narysowaniu wykresu program będzie czekał na wciśnięcie dowolnego klawisza a gdy to
nastąpi, wróci do trybu tekstowego.

    10 hgr 1,0
    20 cls
    30 line 160,0,160,200
    40 line 0,100,320,100
    50 ink 3
    60 x=0.1*(0-160)+1e-6
    70 plot 0,100-100*sin(x)/x,1
    80 for i=1 to 319
    90 x=0.1*(i-160)+1e-6
    100 line to i,100-100*sin(x)/x
    110 next
    120 pause
    130 nrm
    run

Wykres będzie się składał z żółtych pikseli na czarnym tle a ramka będzie miała niezmieniony kolor. Kolor
osi będzie biały jednak ze względu na niedoskonałości układu graficznego VIC-II w miejscach, gdzie żółty
wykres zbliża się do osi, kolor osi zmieni się w tych miejscach na żółty.

### TEXT

Komenda LINE służy do rysowania odcinków o podanych współrzędnych początku i końca odcinka. Składnia:

    TEXT [@x, y,] "treść" [, hscale=1 [, space=1 [, delay=0 [, drawmode=1]]]]

Opcjonalne współrzędne *x* i *y* to odpowiednio numer kolumny w zakresie 0 do 319 licząc od lewej do prawej i
numery wiersza w zakresie 0 do 199 licząc od góry do dołu. Obie wartości mogą być rzeczywista. Opcjonalny parametr
*hscale* jest mnożnikiem szerokości litery. Domyślna wartość to 1 - normalna szerokość. Gdy ten parametr jest 
równy np. 2 to litery będą dwa razy szersze (symulacja liter wytłuszczonych). Kolejny opcjonalny
parametr *space* to odstęp między literami, który domyślnie wynosi 1 piksel. Zwiększenie tego parametru
dale efekt rozstrzelonych liter. Następny opcjonalny parametr *delay* decyduje o prędkości rysowania napisu.
Domyślnie jest on równy 0 czyli rysowanie z pełną prędkością. Jeśli będzie miał wartość większą niż 0 to
po narysowaniu każdej kolumny litery zostanie wstawione opóźnienie wynoszące około 1/60 sekundy pomnożone
przez *delay*. Na przykład mała litera "o" składa się z 7 kolumn więc całkowity czas rysowania tej litery
z parametrem *delay* = 2 będzie wynosił 14/60 sekundy. Ostatni opcjonalny parametr *drawmode* może mieć
jedną z 3 wartości: 0 - wartość piksela będzie 0, 1 - wartość piksela będzie 1, 2 - wartość piksela zostanie
zanegowana.

Jednak, żeby napis się pojawił trzeba wcześniej załadować czcionki. Definicje czcionek muszą zostać
załadowane do pamięci komputera w formie czterech tablic po 31 znaków:

* $A000-$A19F - chr$(33)-chr$(63), znaki interpunkcyjne i cyfry
* $A1A0-$A367 - chr$(65)-chr$(95), małe litery
* $A368-$A51F - chr$(95)-chr$(127), wielkie litery
* $A520-$A7FF - chr$(161)-chr$(191), polskie znaki

W źródłach WORDPROCESSOR BASIC znajduje się przykładowa czcionka o nazwie PLFONTSLG.PRG. Ta
czcionka ma specjalny mikroprogram ładujący czcionkę do obszaru $A000-$A7FF. Czcionkę trzeba
załadować poleceniem:

    LOAD "PLFONTSLG",8

a następnie uruchomić poleceniem `RUN`.

**Przykład 4, animowany napis**

Poniższy program przełączy się w tryb graficzny, wyczyści ekran i narysuje napis "Hello World!", którego
lewy górny narożnik będzie w punkcie (8, 8). Ten napis będzie pogrubiony, odstęp między literami będzie
zwiększony do 2 pikseli, a poszczególne litery będą rysowane w spowolnionym tempie. Następnie program
odczeka 1,5 sekundy i pod spodem napisze w tej samej linii 3 razy napis hello z odstępami 0,5 sekundy.
Po narysowaniu ostatniego "hello" program będzie czekał na wciśnięcie dowolnego klawisza a gdy to nastąpi,
wróci do trybu tekstowego.

    10 hgr 1,0
    20 cls
    30 text @8,8,"Hello World!",2,2,1,1
    40 pause 90
    50 text @8,20,"Hello"
    60 pause 30
    70 text ", hello"
    80 pause 30
    90 text ", hello!"
    100 pause
    110 nrm
    run

Wszystkie napisy będą białe na czarnym tle.

Słowo kluczowe `TEXT` może również wystąpić w wyrażeniach arytmetycznych. Jest to nazwa funkcji, której
zadaniem jest obliczyć jaką szerokość zajmie podany napis na ekranie graficznym. Oczywiście ta funkcja
niczego nie rysuje a tryb graficzny nie musi być wtedy włączony. Ważne, żeby były załadowane czcionki
w pamięci operacyjnej pod adresem $A000-$A7FF. Składnia:

    TEXT("treść", hscale, space)

Parametry *hascale* i *space* mają takie samo znaczenie ale tym razem są obowiązkowe.

**Przykład 5, centrowanie napisów**

    10 hgr 1,0
    20 cls
    30 t$="Hello World!"
    40 s$="Hello, hello, hello!"
    50 ink 6
    60 text @160-text(t$,2,6)/2,8, t$, 2,6
    70 ink 5
    80 text @160-text(s$,1,1)/2,28, s$
    90 pause
    100 nrm
    run

Górny napis będzie pogrubiony (skala 2) a jego litery będą rozstrzelone z odstępem 6 pikseli.
Dolny napis będzie napisany normalną wielkością ale jak widać w funkcji text() muszą wystąpić dwie
wartości 1 choć komenda rysująca tekst ich nie potrzebuje. Górny napis będzie w kolorze niebieskim a 
dolny w kolorze zielonym. Żeby kolor zielony nie zachodził na niebieski, napis dolny musi być obniżony
o odpowiednią odległość.

### DRAW

Komenda DRAW służy do rysowania łamanej, której odcinki zmieniają kąt nie mniej niż 45&deg; względem siebie.
Składnia:

    DRAW [@x, y,] "kształt" [, rot=0 [, delay=0 [, drawmode=1]]]

Opcjonalne współrzędne *x* i *y* to odpowiednio numer kolumny w zakresie 0 do 319 licząc od lewej do prawej i
numery wiersza w zakresie 0 do 199 licząc od góry do dołu. Obie wartości mogą być rzeczywista. Opcjonalny
parametr *rot* to globalny obrót rysunku, który domyślnie wynosi 0 czyli bez obrotu. Zwiększenie tego
parametru w zakresie 1, 2, ... 7 daje obrót *rot* &times; 45&deg;. Następny opcjonalny parametr *delay* decyduje
o prędkości rysowania punktów na ekranie. Domyślnie jest on równy 0 czyli rysowanie z pełną prędkością.
Jeśli będzie miał wartość większą niż 0 to po narysowaniu każdego punktu zostanie wstawione opóźnienie
wynoszące około 1/60 sekundy pomnożone przez *delay*. Ostatni opcjonalny parametr *drawmode* może mieć
jedną z 3 wartości: 0 - wartość piksela będzie 0, 1 - wartość piksela będzie 1, 2 - wartość
piksela zostanie zanegowana.

Definicja kształtu to wyrażenie tekstowe, którego znaki mają specjalne znaczenie dla komendy DRAW. Każdy ruch
może się odbywać w jednym z 8. kierunków na podaną odległość:

    "<k1>[<d2>]<k2>[<d2>]<k3>[<d3>] ... <kn>[<dn>]"

Kierunki są wyznaczone przez litery 'a' ... 'h' gdy komenda DRAW ma rysować i 'A' ... 'H' gdy ma nie rysować
punktów. Litery "a" i "A" to ruch w prawo, litery "b", "B" to ruch skośny prawo-dół i tak dalej zgodnie 
z ruchem wskazówek zegara. Odległości są podawane w pikselach w zakresie 1 do 255 (liczba całkowita).
Jeśli dystans zostanie pominięty to DRAW przyjmie wartość 1.

**Przykład 6, animowany ośmiokąt**

Poniższy program przełączy się w tryb graficzny, wyczyści ekran i będzie rysował ośmiokąt narysowany
z odcinków w połowie narysowanych a w połowie nie, który obróci się 8 razy wokół środka ekranu. Po usunięciu
ostatniego ośmiokąta program wróci do trybu tekstowego i zakończy działanie.

    10 hgr 1,0
    20 cls
    30 dram$="a10A10b10B10c10C10d10D10e10E10f10F10g10G10h10H10"
    40 for i=0 to 7
    50 draw @160,100,dram$,i,0,2
    60 pause 30
    70 draw @160,100,dram$,i,0,2
    80 next
    100 nrm
    run

Figura będzie miała kolor biały na czarnym tle.

### FILL

Komenda FILL służy do wypełniania pamięci kolorów w trybie wysokiej rozdzielczości. Można zmieniać
prostokątny obszar ekranu o podanych współrzędnych lewego górnego narożnika i o podanych rozmiarach.
Składnia:

    FILL row, col, width, height [, fgcolor [, bgcolor]]

Kolory w trybie wysokiej rozdzielczości można zmieniać dla prostokątów o rozmiarach 8&times;8 pikseli.
Ekran wysokiej rozdzielczości ma 1000 takich prostokątów (25 wierszy po 40 kolumn). Pierwszy parametr
*row* ustala numer wiersza w zakresie 0 do 24, od którego zaczyna się prostokątny obszar zmiany koloru.
Parametr *col* ustala numer kolumny w zakresie 0 do 39. Parametry *width* i *heigth* ustalają rozmiar
obszaru - odpowiednio szerokość (liczba kolumn) i wysokość (liczba wierszy). Opcjonalny parametr
*fgcolor* ustawia kolor piksela o wartości 1 (w zakresie 0-15) a parametr *bgcolor* - kolor piksela
o wartości 0 (też w zakresie 0-15). Jeśli parametry *fgcolor* lub *bgcolor* nie zostaną podane to
FILL przyjmie kolory ustalone przez polecenie INK. Jeśli kolory zostaną podane, to staną się nowymi
kolorami domyślnymi.

**Przykład 7, nogowanie półekranów**

    10 hgr 1,0
    20 cls
    30 line 0,0,320,200:line 0,200,320,0
    40 pause 60
    50 fill 0,20,20,25,0,1
    60 pause 60
    70 fill 0,0,20,25,0,1
    80 pause 60
    90 fill 0,20,20,25,1,0
    100 pause 60
    110 fill 0,0,20,25,1,0
    120 pause 60
    130 nrm
    run

Program wyświetli białe przekątne ekranu na czarnym tle a następnie, co 50 sekund neguje kolor
lewej i prawej połowy ekranu.

## Zmiany istniejących komend BASIC-a

### RESTORE

Wbudowana komenda RESTORE nie ma parametrów i cofa wskaźnik *DATA* zawsze na początek programu. WPBASIC
pozwala na podanie numeru linii do której ma się cofnąć wskaźnik *DATA*. Składnia:

    RESTORE [linenumber]

Parametr *linenumber* może być dowolnym wyrażeniem arytmetycznym, które zostanie zaokrąglone do liczby
całkowitej 16-bitowej bez znaku, jednak trzeba pamiętać, że CBM BASIC dopuszcza jedynie numery linii
w zakresie 0..63999. Linia o wskazanym numerze nie musi istnieć bo jeśli RESTORE nie znajdzie takiej
linii to ustawi wskaźnik na następnej linii.

**Przykład 8, eksperymenty z RESTORE**

    10 restore 110
    20 read a,b: print 110,a,b
    30 restore 100
    40 read c,d: print 100,c,d
    50 restore 120
    60 read e,f: print 120,e,f
    100 data 10,20,30,40
    110 data 50,60,70,80
    run

Ten program zakończy się błędem `?out of data error in 60` bo `restore 120` ustawi wskaźnik na końcu
programu i komenda `read` nie znajdzie już żadnych danych od odczytania. Wcześniej na ekranie wyświetli
się `110  50  60` i `100  10  20`.
