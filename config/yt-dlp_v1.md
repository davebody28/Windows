# yt-dlp v1
Bash files files

1) Plik download_mp3.bat (zapisz obok urls.txt i uruchom w cmd / dwuklikiem)

``` batch
@echo off
setlocal

:: Katalog skryptu
set "SCRIPTDIR=%~dp0"

:: Nazwa pliku z linkami
set "URLFILE=%SCRIPTDIR%urls.txt"

:: Gdzie zapisać MP3 (możesz zmienić)
set "OUTDIR=%SCRIPTDIR%mp3s"

:: Sprawdzenia
if not exist "%URLFILE%" (
  echo Plik urls.txt nie znaleziony w %SCRIPTDIR%
  echo Utworz urls.txt (kazdy URL w nowej linii) i uruchom ponownie.
  pause
  exit /b 1
)

where yt-dlp >nul 2>&1
if errorlevel 1 (
  echo Nie znaleziono yt-dlp w PATH.
  echo Zainstaluj go: python -m pip install -U yt-dlp  lub pobierz yt-dlp.exe i dodaj do PATH.
  pause
  exit /b 1
)

where ffmpeg >nul 2>&1
if errorlevel 1 (
  echo Nie znaleziono ffmpeg w PATH.
  echo Pobierz ffmpeg i dodaj go do PATH (wymagane do konwersji).
  pause
  exit /b 1
)

:: Stworz katalog wyjsciowy
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

echo Rozpoczynam pobieranie i konwersje do MP3...
echo Źródło: %URLFILE%
echo Wyjscie: %OUTDIR%
echo.

:: Komenda yt-dlp:
:: -a : read URLs from file
:: -f bestaudio : wybierz najlepszy audio-only format
:: --extract-audio --audio-format mp3 --audio-quality 0 : konwersja do MP3 z najlepsza jakoscia
:: -o : template nazwy pliku; ext bedzie .mp3 po konwersji
:: --embed-thumbnail --add-metadata : opcjonalne (osadz miniaturke i metadane) - wymaga ffmpeg
yt-dlp -a "%URLFILE%" -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o "%OUTDIR%\%(title)s.%(ext)s" --embed-thumbnail --add-metadata --no-mtime --ignore-errors

echo.
echo Gotowe.
pause
endlocal
```

2) Prosty jednolinijkowy command (uruchom w katalogu z urls.txt)

``` batch
yt-dlp -a urls.txt -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o "mp3s/%(title)s.%(ext)s" --embed-thumbnail --add-metadata --no-mtime
```

3) Przykładowy urls.txt (każdy URL w nowej linii)

``` batch
https://www.youtube.com/watch?v=VIDEO_ID_1
https://www.youtube.com/watch?v=VIDEO_ID_2
# Możesz dodać playlisty lub bezposrednie linki do plików
```