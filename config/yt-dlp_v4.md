# yt-dlp v4
PowerShell based

## Features:
* ✅ sam sprawdza / pobiera / aktualizuje yt-dlp
* ✅ sam sprawdza / pobiera ffmpeg (static build)
* ✅ ma MOCNO podkręcone parametry równoległości (pod dobrego kompa + net)
* ✅ best audio extraction
* ✅ MP3 high quality
* ✅ pełne ID3 (artist / title / album / track / thumbnail)
* ✅ download archive (baza)
* ✅ log + error log
* ✅ gotowy do task schedulera / CRON-a


## 1️⃣ PowerShell – 📄 run.ps1

``` powershell
powershell -ExecutionPolicy Bypass -File yt-dlp_mp3_ultra.ps1
```

## 2️⃣ Powershell - 📄 yt-dlp_mp3_ultra.ps1

``` powershell
# =========================================================
# yt-dlp MP3 ULTRA Downloader (Auto Update + ID3 + Parallel)
# =========================================================

$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $BaseDir

# ---------- ŚCIEŻKI ----------
$BinDir    = "$BaseDir\bin"
$YtDlpExe  = "$BinDir\yt-dlp.exe"
$FfmpegExe = "$BinDir\ffmpeg.exe"

$UrlFile = "urls.txt"
$OutDir  = "mp3s"
$Archive = "archive.txt"
$LogFile = "yt-dlp.log"
$ErrLog  = "yt-dlp-errors.log"

# ---------- PERFORMANCE (PODKRĘCONE) ----------
$ParallelFiles     = 8     # ile plików naraz
$ParallelFragments = 16    # ile fragmentów na plik

# ---------- AUDIO ----------
$AudioFormat  = "mp3"
$AudioQuality = "0"        # best VBR

# ---------- STABILNOŚĆ ----------
$Retries          = 20
$FragmentRetries  = 20
$SocketTimeout    = 30
$ConcurrentFragments = 16

# ---------- FLAGS ----------
$RestrictNames  = $true
$EmbedMetadata  = $true
$EmbedThumbnail = $true
$QuietMode      = $false

# =========================================================
# FUNKCJE
# =========================================================

function Ensure-Dir($Path) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Download-File($Url, $OutFile) {
    Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing
}

# =========================================================
# INIT
# =========================================================

Ensure-Dir $BinDir
Ensure-Dir $OutDir

# =========================================================
# yt-dlp AUTO UPDATE
# =========================================================

Write-Host "🔄 Sprawdzam yt-dlp..."
if (-not (Test-Path $YtDlpExe)) {
    Write-Host "⬇️  Pobieram yt-dlp..."
    Download-File "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe" $YtDlpExe
} else {
    & $YtDlpExe -U | Out-Null
}

# =========================================================
# FFMPEG AUTO INSTALL
# =========================================================

Write-Host "🔄 Sprawdzam ffmpeg..."
if (-not (Test-Path $FfmpegExe)) {
    Write-Host "⬇️  Pobieram ffmpeg..."
    $Zip = "$BinDir\ffmpeg.zip"
    Download-File "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip" $Zip
    Expand-Archive $Zip $BinDir -Force
    Get-ChildItem "$BinDir\ffmpeg-*\bin\ffmpeg.exe" | Copy-Item -Destination $FfmpegExe
    Remove-Item $Zip -Force
}

# =========================================================
# WALIDACJA
# =========================================================

if (-not (Test-Path $UrlFile)) {
    Write-Host "❌ Brak urls.txt" -ForegroundColor Red
    exit 1
}

# =========================================================
# YT-DLP ARGUMENTY
# =========================================================

$Args = @(
    "-a", $UrlFile,
    "-f", "bestaudio/best",
    "--extract-audio",
    "--audio-format", $AudioFormat,
    "--audio-quality", $AudioQuality,
    "-o", "$OutDir/%(artist|uploader)s - %(title)s.%(ext)s",
    "--download-archive", $Archive,
    "-j", $ParallelFiles,
    "-N", $ParallelFragments,
    "--concurrent-fragments", $ConcurrentFragments,
    "--retries", $Retries,
    "--fragment-retries", $FragmentRetries,
    "--socket-timeout", $SocketTimeout,
    "--ignore-errors",
    "--no-mtime",
    "--ffmpeg-location", $BinDir,
    "--log-to-file", $LogFile
)

if ($EmbedMetadata)  { $Args += "--add-metadata" }
if ($EmbedThumbnail) { $Args += "--embed-thumbnail" }
if ($RestrictNames)  { $Args += "--restrict-filenames" }
if ($QuietMode)      { $Args += "--quiet"; $Args += "--no-warnings" }

# =========================================================
# START
# =========================================================

Write-Host "🚀 START yt-dlp ULTRA"
Write-Host "⚡ Parallel files:     $ParallelFiles"
Write-Host "⚡ Parallel fragments: $ParallelFragments"
Write-Host "🎵 Audio: best → MP3"
Write-Host ""

& $YtDlpExe @Args 2>> $ErrLog

Write-Host ""
Write-Host "✅ ZAKOŃCZONE"
```

## 2️⃣ Struktura katalogu

``` lua
yt-dlp/
│── yt-dlp_mp3_ultra.ps1
│── urls.txt
│── archive.txt
│── yt-dlp.log
│── yt-dlp-errors.log
│
├── bin/
│   ├── yt-dlp.exe
│   └── ffmpeg.exe
│
└── mp3s/
    ├── Artist - Title.mp3
```