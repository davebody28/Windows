# yt-dlp v3
PowerShell based

## Features:
* ✅ best audio extraction
* ✅ równoległe pobieranie (pliki + fragmenty)
* ✅ download archive (baza)
* ✅ pełne logowanie (log + error log)
* ✅ retry / timeout / stabilność
* ✅ czytelny output + opcjonalny quiet mode
* ✅ łatwe warianty do włączania/wyłączania


## 1️⃣ PowerShell – download_mp3_parallel.ps1
Uruchamiaj z PowerShella (nie CMD):
.\download_mp3_parallel.ps1

``` powershell
# =========================
# yt-dlp PowerShell Runner
# =========================

# --------- KONFIGURACJA ---------

$UrlFile   = "urls.txt"
$OutDir    = "mp3s"
$Archive   = "archive.txt"
$LogFile   = "yt-dlp.log"
$ErrLog    = "yt-dlp-errors.log"

# Równoległość
$ParallelFiles     = 3      # ile plików naraz
$ParallelFragments = 4      # ile fragmentów na plik

# Audio
$AudioFormat  = "mp3"
$AudioQuality = "0"         # 0 = best VBR

# Retry / stabilność
$Retries        = 10
$FragmentRetries= 10
$SocketTimeout = 30

# Opcjonalne flagi (true / false)
$EmbedMetadata   = $true
$EmbedThumbnail  = $true
$RestrictNames   = $true
$QuietMode       = $false   # true = cisza w konsoli, wszystko w logu

# --------------------------------

# ======= WALIDACJA =======

if (-not (Test-Path $UrlFile)) {
    Write-Host "❌ Brak pliku urls.txt" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command yt-dlp -ErrorAction SilentlyContinue)) {
    Write-Host "❌ yt-dlp nie znaleziony w PATH" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "❌ ffmpeg nie znaleziony w PATH (wymagany!)" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $OutDir)) {
    New-Item -ItemType Directory -Path $OutDir | Out-Null
}

# ======= BUDOWANIE KOMENDY =======

$Args = @(
    "-a", $UrlFile,
    "-f", "bestaudio/best",
    "--extract-audio",
    "--audio-format", $AudioFormat,
    "--audio-quality", $AudioQuality,
    "-o", "$OutDir/%(title)s.%(ext)s",
    "--download-archive", $Archive,
    "-j", $ParallelFiles,
    "-N", $ParallelFragments,
    "--retries", $Retries,
    "--fragment-retries", $FragmentRetries,
    "--socket-timeout", $SocketTimeout,
    "--ignore-errors",
    "--no-mtime",
    "--log-to-file", $LogFile
)

if ($EmbedMetadata)  { $Args += "--add-metadata" }
if ($EmbedThumbnail) { $Args += "--embed-thumbnail" }
if ($RestrictNames)  { $Args += "--restrict-filenames" }
if ($QuietMode)      { $Args += "--quiet"; $Args += "--no-warnings" }

# ======= START =======

Write-Host "===================================="
Write-Host " yt-dlp MP3 PARALLEL DOWNLOADER (PS)"
Write-Host "===================================="
Write-Host "URLs:        $UrlFile"
Write-Host "Output:      $OutDir"
Write-Host "Archive:     $Archive"
Write-Host "Log:         $LogFile"
Write-Host "Parallel:    $ParallelFiles files / $ParallelFragments fragments"
Write-Host "====================================`n"

yt-dlp @Args 2>> $ErrLog

Write-Host "`n===================================="
Write-Host " ZAKOŃCZONE"
Write-Host "===================================="
```

## 2️⃣ Struktura katalogu

``` lua
yt-dlp/
│── download_mp3_parallel.ps1
│── urls.txt
│── archive.txt
│── yt-dlp.log
│── yt-dlp-errors.log
└── mp3s/
    ├── track1.mp3
    ├── track2.mp3
```