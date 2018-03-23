# WORDPROCESSOR BASIC

Rozszerzenia BASICA zazwyczaj umieszcza się pod wbudowanym
BASIC-iem rozpoczynając od adresu $9000 lub $8000. Drugi adres jest przeznaczony dla większych
rozszerzeń (niemieszczących się w 4 KB pamięci) albo gdy produkt ma być
rozprowadzany w formie cartridga. WORDPROCESSOR BASIC, w skrócie WPBASIC, jest mały i mieście się
z powodzeniem w 4 KB, więc aby nie tracić przestrzeni przeznaczonej na programy BASIC-a, zdecydowałem się na
obszar pamięci $9000-$9FFF. Obszar przeznaczony na programy BASIC-a zmniejsza się wówczas z 38 KB na 34 KB.
Nadal jest to bardzo dużo.

WPBASIC ma za zadanie:

1. przełączać komputer w tryb wysokiej rozdzielczości i z powrotem do trybu tekstowego,

2. umożliwić tworzenie i poruszanie spritami,

3. pozwolić na odtwarzanie muzyki w tle.

Aby nie tracić cennej pamięci RAM zdecydowałem się umieścić tryb graficzny pod tym samym adresem
co KERNAL czyli $E000-$FFFF. Utrudnia to odczytanie pamięci graficznej, ale w założeniach przewodnik
nie miał czytać pamięci ekranu. Na marginesie, idąc tym tropem można by pokusić się o technikę
*double buffer* - czyli gdy pierwsza ramka animacji jest widoczna, to druga ramka animacji, w tym samym
czasie, jest renderowana. Jako drugi bufor można by wykorzystać pamięć "pod" BASIC-iem czyli w
zakresie $A000-$BFFFF. W takim wypadku wystarczy przełączyć tylko bank pamięci układu VIC-II w CIA #2.
Najlepszymi momentami na przełączenia banku byłoby przerwanie generowane podczas powrotu plamki na
górę ekranu.

Aby maksymalnie uprościć ładowanie i uruchamianie programu `wpbasic.prg`, zdecydowałem się na 
wariant ładowania programu `wpbasic.prg` do obszaru przeznaczonego na programy BASIC-a czyli
poczynając od adresu $0801. Ponieważ taki program trudno byłoby uruchomić więc na samym początku
programu  `wpbasic.prg` jest zasymulowany jednolinijkowy program w BASIC-u z komendą:

    SYS(2063)

Dzięki temu rozszerzenie WPBASIC można uruchomić standardową komendą:

    RUN

Pod adresem 2063 ($080F) znajduje się maleńki programik, który kopiuje kod maszynowy programu
`wpbasic.prg` pod właściwy adres $9000 i wykonuje skok do procedury `init`, która inicjuje program.
