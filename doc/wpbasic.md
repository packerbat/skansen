# WORDPROCESSOR BASIC

## Uruchamianie

Niestety nie pamiętam, dlaczego to rozszerzenie BASIC-a nazywa się WORDPROCESSOR BASIC, ale tak
go nazwałem i na razie zachowuję tę nazwę. Rozszerzenie najprościej załadować specjalnym programem
ładującym o nazwie `BOOTLOADER.PRG`:

    LOAD "BOOTLOADER",8

który po załadowaniu, uruchamiamy poleceniem:

    RUN

Ten mini program ładujący wczyta dwa pliki: WPBASIC.PRG i PLFONTSLG.PRG, umieści je w odpowiednim
miejscu pamięci operacyjnej a następnie uruchomi procedurę inicjującą rozszerzenie BASIC-a.

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

Komenda CLS służy do wyczyszczenia ekranu w trybie graficznym. Komenda czyści ekran wysokiej
rozdzielczości (ustawia wszystkie bity na 0) oraz wypełnia pamięć kolorów kolorami *fgcolor*
i *bgcolor* podanymi w tej komendzie a jeśli kolory nie będą zdefiniowane to ostatnimi kolorami
podanymi w komendach HGR lub INK. Składnia:

    CLS [fgcolor [, bgcolor [, framecolor]]]

Wszystkie 3 kolory są liczbami całkowitymi w zakresie 0-15 i jak widać są to parametry opcjonalne.

### NRM

Komenda NRM służy do przełączania układu VIC-II w tryb tekstowy (40 &times; 25).
Składnia:

    NRM [chrcolor [, bgcolor [, framecolor]]]

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

    10 hgr 0,1
    20 cls
    30 line 160,0,160,200
    40 line 0,100,320,100
    50 x=0.1*(0-160)+1e-6
    60 plot 0,100-100*sin(x)/x,1
    70 for i=1 to 319
    80 x=0.1*(i-160)+1e-6
    90 line to i,100-100*sin(x)/x
    100 next
    110 pause
    120 nrm
    run

Wykres będzie się składał z czarnych pikseli na białym tle a ramka będzie miała niezmieniony kolor.

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

**Przykład 4, animowany ośmiokąt**

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
Ta funkcja nie czyści ekranu (nie ustawia pikseli na wartość 0) dlatego kolor można zaaplikować już
po narysowaniu rysunku. Składnia:

    FILL row, col, width, height [, fgcolor [, bgcolor]]

Kolory w trybie wysokiej rozdzielczości można zmieniać dla prostokątów o rozmiarach 8&times;8 pikseli.
Ekran wysokiej rozdzielczości ma 1000 takich prostokątów (25 wierszy po 40 kolumn). Pierwszy parametr
*row* ustala numer wiersza w zakresie 0 do 24, od którego zaczyna się prostokątny obszar zmiany koloru.
Parametr *col* ustala numer kolumny w zakresie 0 do 39. Parametry *width* i *heigth* ustalają rozmiar
obszaru - odpowiednio szerokość (liczba kolumn) i wysokość (liczba wierszy). Opcjonalny parametr
*fgcolor* ustawia kolor piksela o wartości 1 (w zakresie 0-15) a parametr *bgcolor* - kolor piksela
o wartości 0 (też w zakresie 0-15). Jeśli parametry *fgcolor* lub *bgcolor* nie zostaną podane to
FILL przyjmie kolory ustalone przez ostatnie polecenie INK lub HGR lub CLS. Jeśli kolory zostaną podane,
to staną się nowymi kolorami domyślnymi.

**Przykład 5, nogowanie półekranów**

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

WORDPROCESSOR BASIC ładuje na starcie czcionkę w odpowiednie miejsca pamięci pod BASIC ROM. W obecnej wersji
programu czcionki mają zadeklarowane cztery statyczne tablice po 31 znaków:

* $A000-$A19F - chr$(33)-chr$(63), znaki interpunkcyjne i cyfry
* $A1A0-$A367 - chr$(65)-chr$(95), małe litery
* $A368-$A51F - chr$(95)-chr$(127), wielkie litery
* $A520-$A6FF - chr$(161)-chr$(191), polskie znaki

W źródłach WORDPROCESSOR BASIC znajduje się przykładowa czcionka o nazwie PLFONTSLG.PRG. Oprócz tego
znajduje się program FONTLOADER.PRG, który ładuje czcionkę do odpowiedniego obszaru pamięci:

    LOAD "FONTLOADER",8

Potem trzeba wydać polecenie `RUN`.

UWAGA: Czcionka oprócz definicji liter zawiera również tabelę częstotliwości nut potrzebną do odtwarzania
muzyki. Tabela składa się z liczb 16-bitowych, które są podzielnikami zegara 1MHz w układzie SID. Tabela
zajmuje obszar pamięci od $A700-$A7FF czyli zaraz za obszarem z polskimi znakami. W przyszłości tabelę
częstotliwości nut trzeba będzie rozdzielić od czcionek.

**Przykład 6, animowany napis**

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

Wszystkie napisy będą białe na czarnym tle a kolor ramki nie zostanie zmieniony.

Słowo kluczowe `TEXT` może również wystąpić w wyrażeniach arytmetycznych. Jest to nazwa funkcji, której
zadaniem jest obliczyć jaką szerokość zajmie podany napis na ekranie graficznym. Oczywiście ta funkcja
niczego nie rysuje a tryb graficzny nie musi być wtedy włączony. Ważne, żeby były załadowane czcionki
w pamięci operacyjnej pod adresem $A000-$A6FF. Składnia:

    TEXT("treść", hscale, space)

Parametry *hascale* i *space* mają takie samo znaczenie ale tym razem są obowiązkowe.

**Przykład 7, centrowanie napisów**

    10 hgr 1,0
    20 cls
    30 t$="Hello World!"
    40 s$="Hello, hello, hello!"
    50 fill 0,0,40,3,6
    60 text @160-text(t$,2,6)/2,8, t$, 2,6
    70 fill 3,0,40,3,5
    80 text @160-text(s$,1,1)/2,28, s$
    90 pause
    100 nrm
    run

Górny napis będzie pogrubiony (skala 2) a jego litery będą rozstrzelone z odstępem 6 pikseli.
Dolny napis będzie napisany normalną wielkością ale jak widać w funkcji text() muszą wystąpić dwie
wartości 1 choć komenda rysująca tekst ich nie potrzebuje. Górny napis będzie w kolorze niebieskim a 
dolny w kolorze zielonym. Żeby kolor zielony nie zachodził na niebieski, napis dolny musi być obniżony
o odpowiednią odległość. Górny napis "zajmuje" pierwsze 24 linie ekranu (0-23), a napis dolny "zajmuje"
następne 24 linie ekranu (24-47). W obu przypadkach kolor jest zmieniany na całej szerokości 
ekranu (0-319).

### MUSIC

Komenda MUSIC jest rodzajem kompilatora ścieżki muzycznej. Jej zadaniem jest przekonwertować string 
podany jako parametr i zawierający ciąg nut na ciąg nut w formie binarnej oraz zapamiętać ten ciąg
pod wybranym numerem melodii. Obecnie może być 15 melodii po 128 zdarzeń. Melodie są zapamiętywane
w obszarze pamięci od $B100-$BFFF (czyli pod BASIC ROM). Składnia:

    MUSIC melid, "melodia"

Parametr *melid* to numer melodii w zakresie 1-15 a tekstowy parametr *melodia* to melodia, którą
chcemy zdefiniować. Składnia parametru *melodia* jest następująca:

    <event1><event2>...

Zdarzenia muzyczne *event1*, *event2*, ... to nie tylko nuty do zagrania ale także pauzy i komendy
sterujące układem SID.

1. Jeśli zdarzenie rozpoczyna znak c,C,d,D,e,f,F,g,G,a,A,h to jest to nuta. Po tym znaku może wystąpić
   opcjonalny numer oktawy w zakresie 0-7 a po nim opcjonalny czas trwania nuty w 1/60 sekundy przy czym
   zostanie dodana automatycznie 1/60 sekundy na przerwę miedzy nutami. Jeśli oktawa i długość nuty
   nie zostaną podane to te wartości zostaną pobrane z nuty zdefiniowanej bezpośrednio wcześniej. Jeśli
   bezpośrednio wcześniejszym zdarzeniem był pauza to przyjęta zostaje długość pauzy a oktawa jest od
   ostatniej nuty.

2. Jeśli zdarzenie rozpoczyna znak '.' to jest to pauza. Po kropce może wystąpić opcjonalny czas trwania
   pauzy w 1/60 sekundy. Między pauzami nie ma przerw więc jeśli ćwierćnuta ma długość 47/60 (czyli 48/60 
   po uwzględnieniu 1/60 sekundy między nutami) to pauza ćwierćnutowa musi być zdefiniowana jako ".48".
   Jeśli długość pauzy nie zostanie zdefiniowana to zostanie wzięta długość nuty/pauzy bezpośrednio 
   wcześniejszej.

3. Jeśli zdarzenie rozpoczyna znak '*' to jest to polecenie zmieniające rejestr sterujący bieżącego generatora.
   Po znaku '*' musi być podana 2-cyfrowa liczba szesnastkowa, która będzie nową wartością tego rejestru

4. Jeśli zdarzenie rozpoczyna znak '!' to jest to polecenie zmieniające rejestr bieżącego generatora albo
   zmieniające rejestry wspólne dla wszystkich generatorów. Po znaku '!' muszą wystąpić dwie 2-cyfrowe liczby
   szesnastkowe. Pierwsza oznacza numer rejestru dla generatora (jeśli jest w zakresie 00-06) albo numer
   rejestru wspólnego (jeśli jest w zakresie 17-1A). Druga liczba to nowa wartość rejestru.

Przykład:

    music 1, "c448def424ed*10c448def424ed"

oznacza 3 ćwierćnuty c,d,e potem 3 ósemki f,e,d potem zmiana kształtu fali na trójkątną i powtórzenie
tej samej grupy 3 ćwierćnut i 3 ósemek. Wszystkie dźwięki pochodzą z oktawy nr 4.

### VOICE

Komenda VOICE służy to konfigurowania generatorów. Posiada tylko jeden parametr tekstowy, w którym
definiuje się wszystkie parametry generatorów. Składnia:

    VOICE "gen1conf[,gen2conf[,gen3conf]]"

Parametr może definiować pierwszy generator, albo pierwszy i drugi generator albo wszystkie 3 generatory.
Każda definicja generatora ma taką samą budowę:

    AD[SR[FC[0W[WW]]]]

Poszczególne symbole to:

    A - attack w zakresie 0-f (jedna cyfra szesnastkowa)
    D - decay w zakresie 0-f (jedna cyfra szesnastkowa)
    S - sustain w zakresie 0-f (jedna cyfra szesnastkowa)
    R - release w zakresie 0-f (jedna cyfra szesnastkowa)
    F - rodzaj fali: 1-tiangle, 2-sawtooth, 4-pulse, 8-noise
    C - control register: 1-start/stop, 2-synch, 4-ring, 8-test
    0W - starszy bajt szerokości fali prostokątnej
    WW - młodszy bajt szerokości fali prostokątnej

Przykład:

    voice "10f6400800,10f6400800,10f6400800"

oznacza, że wszystkie 3 generatory będą zaprogramowane identycznie:

1. attack 8 ms
2. decay 6 ms
3. sustain 15 (max)
4. release 204 ms
5. fala prostokątna
6. wypełnienie fali prostokątnej 50%


### PLAY

Komenda PLAY służy uruchamia muzyki w tle. Wcześniej muszą być zdefiniowane melodie (MUSIC) i ustawione
generatory (VOICE). Komenda PLAY ma dwie formy:

    PLAY [CONT] tempo, melid1[, melid2[, melid3]]"
    PLAY STOP gen1[, gen2[, gen3]]

Pierwsza forma przypisuje melodie do kolejnych generatorów, a druga forma zatrzymuje wskazane generatory. 
Jeśli wystąpi słowo CONT to melodia będzie odtwarzana bez końca czyli gdy się skończy to PLAY cofnie
wskaźnik nuty na początek i odtwarzanie zacznie się od nowa. Parametr *temp* jest prostym mnożnikiem
całkowitym, który wydłuża czas trwania wszystkich nut i pauz tyle razy i wynosi wartość parametru *tempo*.
Na przykład gdy *tempo* wynosi 2 to melodia będzie odtworzona 2 razy wolniej.

W drugiej formie (PLAY STOP) podajemy numery generatorów w zakresie 1-3 (kolejność nie jest istotna).

Przykład:

    play 1, 4, 5, 6

oznacza, że melodia 4 będzie odtwarzana na generatorze 1, melodia 5 na generatorze 2 i melodia 6 na generatorze 3.
Melodie zostaną odtworzone bez spowolnienia (*tempo*=1)


### SCROLL

Komenda SCROLL jest najmniej uniwersalną komendą. Komenda SCROLL ma dwie formy:

    SCROLL [CONT] "treść" [, hscale=1 [, space=1 [, delay=1]]]
    SCROLL STOP

Pierwsza forma rozpoczyna przewijanie podanej treści od lewej do prawej. Pasek ma stałe miejsce w dolnej
części kranu (lewy górny narożnik to x=32, y=176, a rozmiar to 256 na 16 pikseli). Dzięki tym
nieprzypadkowym wymiarom, procedura przewijania napisu jest bardzo optymalnie napisana i można przewijać
z prędkością 60 FPS. Druga forma zatrzymuje przewijanie napisu (nie czyści paska przewijania). 
Jeśli wystąpi słowo CONT to napis będzie przewijał się w kółko (warto zadbać o kilka spacji na końcu
aby początek nie zlewał się końcem. Opcjonalny parametr
*hscale* jest mnożnikiem szerokości litery. Domyślna wartość to 1 - normalna szerokość. Gdy ten parametr jest 
równy np. 2 to litery będą dwa razy szersze (symulacja liter wytłuszczonych). Kolejny opcjonalny
parametr *space* to odstęp między literami, który domyślnie wynosi 1 piksel. Zwiększenie tego parametru
dale efekt rozstrzelonych liter. Następny opcjonalny parametr *delay* decyduje o prędkości przewijania napisu.
Domyślnie jest on równy 1 czyli przewijanie z pełną prędkością. Jeśli będzie miał wartość większą niż 1 to
będą dokładane kolejne 1/60 sekundy pomiędzy każde przesunięcie.

### SHAPE

Komenda SHAPE jest rodzajem kompilatora, który tekstową definicję sprita zamieni na binarną i umieści
w jednym z 48 bloków pamięci po 64 bajty. Bloki są numerowane do 0 do 47. Komenda SHAPE ma składnię:

    SHAPE blok, "definiacja"

Pierwszy parametr *blok* to numer bloku pamięci w zakresie 0-47. Drugi parametr to 63 wartości 8-bitowe
definiująca kształt sprita. Wartości podaje się jako dwucyfrowe liczby szesnastkowe, przy czym wartość zero
'00' można zastąpić przez '*'. Nie trzeba podawać wszystkich wartości, jeśli na końcu kształtu występują
same zera to definicję można skrócić.

VIC-II oferuje tylko 8 spritów widocznych w danym czasie na ekranie, jednak definicji jest 48 aby można
było w locie zmieniać kształt danego sprita i w ten sposób uzyskać efekt animacji.

### SPRITE

Komenda SPRITE służy do konfigurowania spritów. Ma dwie formy:

    SPRITE nr, kształt [, kolor [, powiększenie [, priorytet]]] [, @x,y]
    SPRITE ON "przełączniki"

Pierwsza forma konfiguruje wskazany sprite a druga forma pozwala aktywować lub ukrywać wskazaną grupę
spritów. Pierwszy parametr *nr* ma wartość w zakresie 0-7 i identyfikuje fizyczny sprite układu VIC-II.
Drugi parametr *kształt* określa numer bloku pamięci z kształtem sprita. Ten parametr może mieć wartość
w zakresie 0-47. Jeśli wcześniej nie zostanie zdefiniowany kształt komendą SHAPE to oczywiście jego
wygląd będzie losowy. Trzeci, opcjonalny parametr *kolor* określa kolor sprita. Czwarty, również
opcjonalny parametr, o nazwie *powiększenie* może jedną z czterech wartość:

* wartość 0 oznacza, że sprite nie będzie powiększony,
* wartość 1 oznacza, że będzie dwukrotnie szerszy,
* wartość 2 oznacza, że będzie dwukrotnie wyższy,
* wartość 3 oznacza, że będzie dwukrotnie powiększony w obu kierunkach.

Piąty, opcjonalny parametr o nazwie "priorytet" będzie decydował czy sprite jest ważniejszy
od treści ekranu pod spritem. Może mieć tylko dwie wartość 0 albo 1. Wartość 0 oznacza, że sprite
będzie zawsze ważniejszy od pikseli pod spritem. Wartość 1 oznacza, że sprite "wejdzie" pod niezerowe
piksele ekranu.

Jeśli wystąpi znak '@' to komenda będzie oczekiwała dwóch liczba, które określą współrzędne sprita na 
ekranie. Współrzędna X może mięć wartość w zakresie 0-370 a współrzędna Y może mieć wartość w zakresie
0-250. Współrzędne spritów są większe niż ekran, żeby można je było ukrywać poza widocznym obszarem ekranu.
Jeśli wystąpią współrzędne to automatycznie sprite zostanie włączony.

Druga forma komendy służy do grupowego włączania i wyłączania spritów. Parametr *przełączniki* składa
się od 1 do 8 znaków a każdy znak może być:

* '1' - odblokuj ten sprite,
* '0' - zablokuje ten sprite,
* '*' - nie zmieniaj stanu.


### PATH

Komenda PATH podobnie, jak SHAPE jest rodzajem kompilatora, który zamieni tekstową ścieżkę animacji
sprita na binarną i umieści ją w jednym z 8 ścieżek. Ścieżka może mieć do 128 kroków. Składnia:

    PATH nr, "definicja"

Pierwszy parametr to numer ścieżki i może mieć wartość 0-7. Definicja kształtu ścieżki to wyrażenie
tekstowe, którego znaki mają specjalne znaczenie dla komendy MOVE. Każdy ruch
może się odbywać w jednym z 8. kierunków na podaną odległość:

    "<k1>[<d2>]<k2>[<d2>]<k3>[<d3>] ... <kn>[<dn>]"

Kierunki są wyznaczone przez litery 'a' ... 'h' (można użyć 'A' ... 'H' bo w przeciwieństwie do DRAW
wielki litery nie powodują znikania sprita). Litery "a" to ruch w prawo, litery "b" to ruch skośny
prawo-dół i tak dalej zgodnie z ruchem wskazówek zegara. Odległości są podawane w pikselach w zakresie
1 do 255 (liczba całkowita). Jeśli dystans zostanie pominięty to PATH przyjmie wartość 1.

### MOVE

Komenda MOVE służy do uruchamiania lub zatrzymywania animacji sprita. Ma dwie formy:

    MOVE [CONT] sprite, ścieżka [, rot=0 [, delay=1]] [,  @x,y] 
    MOVE STOP sprite1[, sprite2[, ...]]

Pierwsza forma rozpoczyna animację skazanego sprite (parametr *sprite* w zakresie 0-7) wzdłuż
podanej ścieżki (parametr *ścieżka* w zakresie 0-7). Opcjonalny parametr *rot* o zakresie
wartości 0-7 pozwala zmienić globalną rotację ścieżki. Kolejny opcjonalny parametr *delay*
określa prędkość animacji. Minimalna i zarazem domyślna wartość tego parametru to 1 czyli
co 1/60 sekundy nastąpi ruch sprita we wskazanym kierunku o 1 piksel.

Opcjonalny parametr rozpoczynający się znakiem '@' określa punkt startowy animacji. Jeśli ten
parametr zostanie pominięty to animacja rozpocznie się od ostatniego punktu, w którym znajdował
się dany sprite.

Droga forma komendy MOVE zatrzymuje animację wskazanych spritów. Kolejność numerów nie ma znaczenia,
ważne żeby numery spritów mieściły się w zakresie 0-7.

### SHIFT

Komenda SHIFT służy do podnoszenia treści okna o stałej szerokości 256 pikseli umieszczonego
na środku ekranu graficznego i obniżonego o 16 pikseli (lewy margines = 32, prawy margines = 32
górny margines = 16). Wysokość tego okna można regulować parametrem
ale tylko ze skokiem 8 pikseli. Procedura podnosi treść o 8 pikseli, a ostatni wiersz wypełnia zerami.
Składnia:

    SHIFT [rows = 18]

Jeśli parametr nie wystąpi to procedura podnosi treść o wysokości 18 wierszy po 8 pikseli.

**Przykład 8, test podnoszenia o 8 pikseli**

    10 hgr 1,0
    20 cls
    30 line 0,0,320,200:line 0,200,320,0
    40 ex=32:ey=16:ew=256:eh=144
    50 line ex-1,ey-1,ex+ew,ey-1:line to ex+ew,ey+eh
    60 line to ex-1,ey+eh:line to ex-1,ey-1
    70 for i=1 to 20
    80 pause 60
    90 shift
    100 next
    110 pause
    120 nrm
    run

Program narysuje dwie skośne linie oraz prostokątną ramkę, która nie będzie przesuwana przez komendę
SHIT. Następnie program, co sekundę, będzie podnosił treść ekranu graficznego wewnątrz ramki
o 8 pikseli.

### UP

Komenda UP służy do podnoszenia treści okna o stałej szerokości 256 pikseli umieszczonego
na środku ekranu graficznego i obniżonego o 16 pikseli (lewy margines = 32, prawy margines = 32
górny margines = 16). Wysokość tego okna można regulować parametrem
ale tylko ze skokiem 8 pikseli. Procedura podnosi treść o 1 piksel, a ostatni wiersz wypełnia albo
zerami albo linią podaną jako drugi parametr. Wypełnienie tej linii może mieć maksymalnie długość
32 bajtów (256 pikseli) i trzeba je podać jako ciąg dwucyfrowych licz szesnastkowych (wartość zero
można zastąpić znakiem '*'). Jeśli podany ciąg liczb jest krótszy to brakujące bajty zostaną wypełnione
zerami. Składnia:

    UP [rows = 18 [, "patern"]]

Jeśli parametr nie wystąpi to procedura podnosi treść o wysokości 18 wierszy po 8 pikseli.

**Przykład 9, test podnoszenia o 1 pikseli**

    10 hgr 1,0
    20 cls
    30 line 0,0,320,200:line 0,200,320,0
    40 ex=32:ey=16:ew=256:eh=144
    50 line ex-1,ey-1,ex+ew,ey-1:line to ex+ew,ey+eh
    60 line to ex-1,ey+eh:line to ex-1,ey-1
    70 for i=1 to 20
    80 pause 60
    90 up 18,"0000000000000000000000000000000000000000000000000000000000000000"
    100 next
    110 pause
    120 nrm
    run

Program narysuje dwie skośne linie oraz prostokątną ramkę, która nie będzie przesuwana przez komendę
UP. Następnie program, co sekundę, będzie podnosił treść ekranu graficznego wewnątrz ramki
o 1 piksel. W linii 90 pokazane jest wywołanie komendy UP domyślnymi wartościami obu parametrów.

#### SEI

Komenda SEI wywołuje polecenie w języku maszynowym o tej samej nazwie. Polecenie ustawi maskę przerwań, 
a to spowoduje zablokowanie przerwań. Uwaga: w trakcie zablokowanych przerwań nie działa klawiatura
i jeszcze kilka innych podzespołów dlatego to polecenie trzeba używać z ogromną ostrożnością i na
jak najkrótszy czas.

#### CLI

Komenda CLI wywołuje polecenie w języku maszynowym o tej samej nazwie. Polecenie usunie maskę przerwań,
a to spowoduje odblokowanie przerwań.

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
