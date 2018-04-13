# Narzędzia

## Tokenizer

Program w języku BASIC, pisane na Commodore 64 są w trakcie pisania automatycznie zamieniane na
tak zwany *pcode* (pseudo code). Dzięki temu program zajmuje mniej miejsca w pamięci komputera
i jest odrobinę szybciej wykonywany. Zapisując taki program na dyskietce, zapisywany jest
plik w formacie pcode a nie w wersji źródłowej (tekstowej). Program w BASIC-u ma typ PRG
a zatem w jego dwubajtowym nagłówku umieszczony jest adres w pamięci komputera, pod który
należy ten program załadować. W przypadku Commodore 64 ten adres jest równy 2049.

Założenia przy tworzeniu tokenizera były następujące:

* pobranie wersji źródłowej ze wskazanego pliku,
* zapis wersji binarnej do pliku albo do standardowego urządzenia wyjściowego,
* zapis komunikatów o błędach do standardowego urządzenia błędów,
* obsługa plików UTF-8,
* konwersja małych liter ASCII na wielkie litery PETSCII,
* konwersja wielkich liter ASCII na kody PETSCII w zakresie 193-223,
* łatwa edycja tablicy zamiany wybranych kodów UTF-8 na dowolne znaki PETSCII w zakresie 0-255,
* łatwa edycja tablicy słów kluczowych, która pozwala na dopisywanie własnych słów kluczowych.

Dzięki interpretowanemu językowi Python 3.x tablice znaków specjalnych i słów kluczowych można
było umieścić w prost w źródle programu tokenize.py. Tablica słów kluczowych ma postać:

    BASICTokens = {
        0x80: "end",
        0x81: "for",
        0x82: "next",
        0x83: "data",
        ...
        
a tablica znaków specjalnych ma postać:

    SpecialChars = {
        '}': 29,
        'ą': 176,
        'ć': 187,
        'ę': 172,
        ...

W celu "skompilowania" programu *abc.bas* na *abc.prg* trzeba wydać polecenie:

    python tokenize.py -o abc.prg abc.bas


## Listowanie

Jeśli w VICE napiszemy program w języku BASIC i zapiszemy na wirtualnej dyskietce to otrzymamy
plik binarny z pcode. Nie da się go odczytać na innym komputerze bez specjalnego programu
który zamieni tokeny na czytelne słowa. Program do zamiany plików PRG na BAS ma podobne założenia
do programu tokenizera:

* pobranie wersji binarnej ze wskazanego pliku,
* zapis wersji źródłowej (tekstowej) do pliku albo do standardowego urządzenia wyjściowego,
* zapis komunikatów o błędach do standardowego urządzenia błędów,
* obsługa plików UTF-8,
* konwersja wielkie litery PETSCII na małe litery ASCII,
* konwersja kody PETSCII w zakresie 193-223 na wielkie litery ASCII,
* łatwa edycja tablicy zamiany wybranych znaki PETSCII w zakresie 0-255 na kody UTF-8,
* łatwa edycja tablicy słów kluczowych, która pozwala na dopisywanie własnych słów kluczowych.

Dzięki interpretowanemu językowi Python 3.x tablice znaków specjalnych i słów kluczowych można
było umieścić w prost w źródle programu listprg.py. Tablica słów kluczowych ma postać:

    BASICTokens = {
        0x80: "end",
        0x81: "for",
        0x82: "next",
        0x83: "data",
        ...
        
czyli taką samą jak w programie tokenize.py, a tablica znaków specjalnych jest odwrócona i ma postać:

    SpecialChars = {
        29: '}',
        176: 'ą',
        187: 'ć',
        172: 'ę',
        ...

W celu "dekompilacji" programu *abc.prg* na *abc.bas* trzeba wydać polecenie:

    python listprg.py -o abc.bas abc.prg

