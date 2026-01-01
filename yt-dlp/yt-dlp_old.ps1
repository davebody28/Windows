# ================================
# yt-dlp PowerShell Downloader
# ================================

$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $BaseDir

# ----- ŚCIEŻKI -----
$BinDir    = "$BaseDir\bin"
$YtDlpExe  = "$BinDir\yt-dlp.exe"
$FfmpegExe = "$BinDir\ffmpeg.exe"

$UrlFile = "$BaseDir\urls.txt"
$OutDir  = "$BaseDir\downloads"
$Archive = "$BaseDir\archive.txt"

$LogDir  = "$BaseDir\logs"
$LogFile = "$LogDir\yt-dlp.log"
$ErrLog  = "$LogDir\yt-dlp-errors.log"

# ----- PERFORMANCE (MOCNE) -----
# $ParallelFiles     = 8
$ParallelFragments = 16
$ConcurrentFragments = 16

# ----- AUDIO -----
$AudioFormat  = "mp3"
$AudioQuality = "0"   # best VBR

# ----- STABILNOŚĆ -----
$Retries         = 20
$FragmentRetries = 20
$SocketTimeout   = 30

# ================================
# FUNKCJE
# ================================

function Ensure-Dir($Path) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Download-File($Url, $OutFile) {
    Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing
}

# ================================
# INIT
# ================================

Ensure-Dir $BinDir
Ensure-Dir $OutDir
Ensure-Dir $LogDir

# ================================
# yt-dlp AUTO UPDATE
# ================================

if (-not (Test-Path $YtDlpExe)) {
    Write-Host "⬇ Pobieram yt-dlp..."
    Download-File "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe" $YtDlpExe
} else {
    & $YtDlpExe -U | Out-Null
}

# ================================
# ffmpeg AUTO INSTALL
# ================================

if (-not (Test-Path $FfmpegExe)) {
    Write-Host "⬇ Pobieram ffmpeg..."
    $Zip = "$BinDir\ffmpeg.zip"
    Download-File "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip" $Zip
    Expand-Archive $Zip $BinDir -Force
    Get-ChildItem "$BinDir\ffmpeg-*\bin\ffmpeg.exe" | Copy-Item -Destination $FfmpegExe -Force
    Remove-Item $Zip -Force
}

# ================================
# WALIDACJA
# ================================

if (-not (Test-Path $UrlFile)) {
    Write-Host "❌ Brak urls.txt"
    exit 1
}

# ================================
# ARGUMENTY yt-dlp
# ================================

$Args = @(
    "-a", $UrlFile,
    "-f", "bestaudio/best",
    "--js-runtimes", "node",
    "--extract-audio",
    "--audio-format", $AudioFormat,
    "--audio-quality", $AudioQuality,
    "-o", "$OutDir/%(artist|uploader)s - %(title)s.%(ext)s",
    "--download-archive", $Archive,
    # "-j", $ParallelFiles,
    "-N", $ParallelFragments,
    "--concurrent-fragments", $ConcurrentFragments,
    "--retries", $Retries,
    "--fragment-retries", $FragmentRetries,
    "--socket-timeout", $SocketTimeout,
    "--ignore-errors",
    "--no-mtime",
    "--ffmpeg-location", $BinDir,
    "--add-metadata",
    "--embed-thumbnail",
    "--restrict-filenames",
    "--progress",
    "--newline",
    "--progress-template", "download:%(info.id)s %(progress._percent_str)s %(progress._speed_str)s ETA %(progress._eta_str)s"
)

# ================================
# START (progress + log)
# ================================

Write-Host "=== yt-dlp START ==="
Write-Host "Downloads -> $OutDir"
Write-Host ""

& $YtDlpExe @Args 2>> $ErrLog | Tee-Object -FilePath $LogFile

Write-Host ""
Write-Host "=== ZAKOŃCZONE ==="
