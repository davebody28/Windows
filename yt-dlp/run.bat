@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

title yt-dlp Launcher

echo ===============================
echo   yt-dlp AUDIO DOWNLOADER
echo ===============================
echo.
echo  [1] Single (jeden utwór z URL)
echo  [2] Playlist / Mix (wszystko)
echo.
set /p MODE=Wybierz tryb (1 lub 2): 

if "%MODE%"=="1" (
    set PS_MODE=single
) else if "%MODE%"=="2" (
    set PS_MODE=playlist
) else (
    echo.
    echo ❌ Nieprawidłowy wybor
    pause
    exit /b
)

echo.
echo ▶ Uruchamiam tryb: %PS_MODE%
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0yt-dlp.ps1" -Mode %PS_MODE%

echo.
echo ===============================
echo   ZAKOŃCZONE
echo ===============================
pause
