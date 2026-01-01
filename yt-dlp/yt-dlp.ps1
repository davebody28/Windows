param (
    [ValidateSet("single", "playlist")]
    [string]$Mode = "single"
)

# ================================
# CONFIG
# ================================

$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $BaseDir

$BinDir = "$BaseDir\bin"
$YtDlpExe = "$BinDir\yt-dlp.exe"
$FfmpegExe = "$BinDir\ffmpeg.exe"

$UrlFile = "$BaseDir\urls.txt"
$OutDir = "$BaseDir\downloads"
$Archive = "$BaseDir\archive.txt"

$LogDir = "$BaseDir\logs"
$LogFile = "$LogDir\yt-dlp.log"
$ErrLog = "$LogDir\yt-dlp-errors.log"

# ===== PERFORMANCE =====
$MaxParallelJobs = 4     # PRAWDZIWA RÓWNOLEGŁOŚĆ URL-i
$ParallelFragments = 16
$ConcurrentFragments = 16

# ===== AUDIO =====
$AudioFormat = "mp3"
$AudioQuality = "0"

# ================================
# FUNCTIONS
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
# yt-dlp
# ================================

if (-not (Test-Path $YtDlpExe)) {
    Write-Host "⬇ Pobieram yt-dlp..."
    Download-File "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe" $YtDlpExe
}
else {
    & $YtDlpExe -U | Out-Null
}

# ================================
# ffmpeg
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
# MODE FLAGS
# ================================

$PlaylistFlag = if ($Mode -eq "single") { "--no-playlist" } else { "--yes-playlist" }

# ================================
# LOAD URLS
# ================================

$Urls = Get-Content $UrlFile | Where-Object { $_ -and -not $_.StartsWith("#") }

if ($Urls.Count -eq 0) {
    Write-Host "❌ Brak URL-i w urls.txt"
    exit 1
}

Write-Host "▶ Tryb: $Mode"
Write-Host "▶ URL-i: $($Urls.Count)"
Write-Host "▶ Równoległe zadania: $MaxParallelJobs"
Write-Host ""

# ================================
# JOBS
# ================================

$Jobs = @()

foreach ($Url in $Urls) {

    while ($Jobs.Count -ge $MaxParallelJobs) {
        $Jobs = $Jobs | Where-Object { $_.State -eq 'Running' }
        Start-Sleep 1
    }

    $Jobs += Start-Job -ScriptBlock {
        param($Url, $Mode, $YtDlpExe, $BinDir, $OutDir, $Archive, $ParallelFragments, $ConcurrentFragments, $AudioFormat, $AudioQuality, $PlaylistFlag)

        & $YtDlpExe `
            $PlaylistFlag `
            "-f" "bestaudio/best" `
            "--js-runtimes" "node" `
            "--extract-audio" `
            "--audio-format" $AudioFormat `
            "--audio-quality" $AudioQuality `
            "-o" "$OutDir/%(artist|uploader)s - %(title)s.%(ext)s" `
            "--download-archive" $Archive `
            "-N" $ParallelFragments `
            "--concurrent-fragments" $ConcurrentFragments `
            "--ffmpeg-location" $BinDir `
            "--add-metadata" `
            "--embed-thumbnail" `
            "--progress" `
            "--newline" `
            $Url

    } -ArgumentList $Url, $Mode, $YtDlpExe, $BinDir, $OutDir, $Archive, $ParallelFragments, $ConcurrentFragments, $AudioFormat, $AudioQuality, $PlaylistFlag
}

# ================================
# WAIT
# ================================

Write-Host "▶ Oczekiwanie na zakończenie zadań..."
Wait-Job $Jobs | Out-Null
Receive-Job $Jobs | Tee-Object -FilePath $LogFile
Remove-Job $Jobs

Write-Host ""
Write-Host "✅ WSZYSTKO ZAKOŃCZONE"
