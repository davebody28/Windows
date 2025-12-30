# yt-dlp v2
Bash files based

Download_mp_parallel.bat
``` batch
@echo off
setlocal

:: ====== KONFIGURACJA ======
set "URLFILE=urls.txt"
set "OUTDIR=mp3s"
set "ARCHIVE=archive.txt"
set "LOGFILE=yt-dlp.log"

:: Równoległość
set "PARALLEL_FILES=3"
set "PARALLEL_FRAGMENTS=4"
:: ==========================

if not exist "%OUTDIR%" mkdir "%OUTDIR%"

echo ===============================
echo yt-dlp START
echo URLs: %URLFILE%
echo Output: %OUTDIR%
echo Archive: %ARCHIVE%
echo Log: %LOGFILE%
echo ===============================
echo.

yt-dlp ^
  -a "%URLFILE%" ^
  -f bestaudio ^
  --extract-audio ^
  --audio-format mp3 ^
  --audio-quality 0 ^
  -o "%OUTDIR%\%(title)s.%(ext)s" ^
  --download-archive "%ARCHIVE%" ^
  -j %PARALLEL_FILES% ^
  -N %PARALLEL_FRAGMENTS% ^
  --embed-thumbnail ^
  --add-metadata ^
  --ignore-errors ^
  --no-mtime ^
  --log-to-file "%LOGFILE%"

echo.
echo ===============================
echo ZAKONCZONE
echo ===============================
pause
endlocal
```

Struktura katalogu
``` lua
yt-dlp/
│── download_mp3_parallel.bat
│── urls.txt
│── archive.txt
│── yt-dlp.log
└── mp3s/
    ├── utwór1.mp3
    ├── utwór2.mp3
```