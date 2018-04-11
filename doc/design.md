# WORDPROCESSOR BASIC

Rozszerzenia BASICA zazwyczaj umieszcza się pod wbudowanym
BASIC-iem rozpoczynając od adresu $9000 lub $8000. Drugi adres jest przeznaczony dla większych
rozszerzeń (niemieszczących się w 4 KB pamięci) albo gdy produkt ma być
rozprowadzany w formie cartridga. WORDPROCESSOR BASIC, w skrócie WPBASIC, jest mały oryginalnie mieścił się
w 4 KB. Jednak wersja z relokowalnymi modułami i kilkoma dodatkami nie zmieściła się w 4KB, więc aby nie
tracić przestrzeni przeznaczonej na programy BASIC-a, zdecydowałem się na obszar pamięci $8C00-$9FFF
czyli 5KB. Obszar przeznaczony na programy BASIC-a zmniejsza się wówczas z 38 KB na 33 KB.
Nadal jest to bardzo dużo.

WPBASIC ma za zadanie:

1. przełączać komputer w tryb wysokiej rozdzielczości i z powrotem do trybu tekstowego,

2. umożliwić proste operacje graficzne na ekranie wysokiej rozdzielczości,

3. umożliwić tworzenie i poruszanie spritami,

4. pozwolić na odtwarzanie muzyki w tle.

Aby nie tracić cennej pamięci RAM zdecydowałem się umieścić tryb graficzny pod tym samym adresem
co KERNAL czyli $E000-$FFFF. Utrudnia to odczytanie pamięci graficznej bo trzeba każdorazowo wyłączać
oba ROM-y (BASIC i KERNEL) oraz trzeba blokować w tym czasie przerwania. Dalsze oszczędności miejsca to:

1. czcionki pod adresem $A000-$A6FF o wysokości do 16 pikseli i zmiennej szerokości,

2. tablica częstotliwości nut pod adresem $A700-$A7FF,

3. tablica ścieżek do animacji spritów pod adresem $A800-$AFFF (8 ścieżek z maksymalnie 128 krokami),

4. treść przewijanego napisu pod adresem $B000-$B0FF,

5. tablica krótkich melodii pod adresem $B100-$BFFF (15 melodii z maksymalnie 128 nutami),

6. pamięć kolorów dla trybu wysokiej rozdzielczości $D000-$D3FF,

7. tablica definicji spritów pod adresem $D400-$DFFF (48 kształtów).

Jak widać obszar $C000-$CFFF jest nieużywany a to z tej prostej przyczyny, że gdy pisałem
przewodnik w 1987 roku na Commodorze to w tym obszarze pamięci był monitor i asembler.

Aby maksymalnie uprościć ładowanie i uruchamianie programu `wpbasic.prg`, zdecydowałem się na 
napisanie krótkiego programu `bootloader.prg`, który ładuje `wpbasic.prg` pod adres $8C00 a potem
ładuje plik z czcionkami `plfontslg.prg` pod adres $A000. Sam program `bootloader.prg` ładuje się do standardowego
obszaru BASIC-a czyli pod adres $0801. Ponieważ taki program trudno byłoby uruchomić więc na samym początku
programu `bootloader.prg` jest zasymulowany dwulinijkowy program w BASIC-u z komendami:

    1987 SYS(2069)
    2018 NEW

Dzięki temu załadowany program `bootloader.prg` uruchamiamy standardową komendą:

    RUN

Emulator VICE ma również opcję automatycznego uruchamiania programów. Wystarczy VICE uruchomić 
w sposób następujący:

x64 -autostart skansen.d64

gdzie `skansen.d64` jest obrazem dyskietki w formacie napędu 1541 (170KB) powstałym w wyniku
kompilacji.

Z perspektywy czasu widzę, że kilka komend nie powinno być zaimplementowanych. Mam na myśli wszystkie
minikompilatory: MUSIC, PATH, SHAPE i częściowo DRAW. Zamiast tych komend powinny były powstać programy
zewnętrzne (nawet w BASICU), które zapisałyby binarne ścieżki, melodie czy kształty spritów do plików
typu SEQ. Właściwy program wczytywał by te pliki na starcie albo w miarę potrzeby. WPBASIC można by
wyposażyć w wygodną komendę ładującą wskazane pliki pod odpowiednie adresy w pamięci komputera. Jednak
taki model pracy na Commodore 64 był niesłychanie uciążliwy choćby ze względu na jednozadaniowość czy
najwolniejszą stację dyskietek w historii informatyki (wtedy tak nie uważałem).

