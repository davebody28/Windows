# Windows
Config I need out of the box and so on ...


## [Windows Activation](https://github.com/massgravel/Microsoft-Activation-Scripts)
In PowerShell type:
>[!Note]
> ``` powershell
> irm https://get.activated.win | iex
> ```
Pops a new window with some options like activated Windows or Office and some more options.

![PowerShell screenshot](img/IMG_2085.jpg)
![PowerShell screenshot](img/IMG_2086.jpg)


## Windows Defender (deactivation)
> [!Note]
> 1. Windows + R -> gpedit.msc (run as Admin)
> 2. Computer Configuration -> Administrative Templates -> Windows Components -> Microsoft Defender Antivirus -> Turn off Microsoft Defender Antivirus -> Enabled
> 3. Windows + R -> regedit (run as Admin)
> 4. Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender -> DisableAntiSpyware (DWORD; Value=1)

## [Windows 11 Debload](https://github.com/Raphire/Win11Debloat)
A simple, lightweight PowerShell script to remove pre-installed apps, disable telemetry, as well as perform various other changes to customize, declutter and improve your Windows experience. Win11Debloat works for both Windows 10 and Windows 11.
> [!Note]
> ``` powershell
> & ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
> ```

## [Windows ToolKit](https://github.com/ChrisTitusTech/winutil)
This utility is a compilation of Windows tasks I perform on each Windows system I use. It is meant to streamline installs, debloat with tweaks, troubleshoot with config, and fix Windows updates. I am extremely picky about any contributions to keep this project clean and efficient.
> [!Note]
> ``` powershell
> irm "https://christitus.com/win" | iex
> ```

## Windows Config
Some of the programs can be downloaded at [Ninite](https://ninite.com/)


- Coding
    - [Visual Studio Code](https://code.visualstudio.com/download)
    - [GitHub Desktop](https://desktop.github.com/download/) or [GitBash]()
    - [Docker Desktop](https://www.docker.com/products/docker-desktop/)
    - [PuTTY](https://putty.org/index.html)
    - [Notepad++](https://notepad-plus-plus.org/downloads/)
- NAS (QNAP)
    - [QSync](https://www.qnap.com/en/utilities/essentials)
    - [HDP BackUp Agent](https://www.qnap.com/en/utilities/essentials)
- Gaming
    - [Steam](https://store.steampowered.com/about/)
    - [World of Tanks](https://worldoftanks.eu/pl/game/download/)
    - [uTorrent](https://www.utorrent.com/desktop/compare/)
- Photography & Filming
    - [Adobe Lightroom Classic](rutracker.org)
    - [Adobe Photoshop](rutracker.org)
    - [Adobe Premiere Pro](rutracker.org)
    - [Adobe Media Encoder](rutracker.org)
- Audio/DJ
    - [Rekordbox](https://rekordbox.com/en/download/)
    - [Audacity](https://www.audacityteam.org/download/windows/)
    - [yt-dlp](https://github.com/yt-dlp/yt-dlp) & [config](config/yt-dlp.md)
- Ever day use
    - [MS Office](rutracker.org)
    - [Firefox](https://www.firefox.com/pl/?utm_campaign=SET_DEFAULT_BROWSER)
    - [TerraCopy](https://www.codesector.com/teracopy)
    - [7Zip](https://www.7-zip.org/download.html)
    - [GreenShoot](https://getgreenshot.org/downloads/)
    - [ShareX](https://getsharex.com/downloads)
    - [VLC](https://www.videolan.org/vlc/)
    - [ImgBurn](https://www.imgburn.com/index.php?act=download)


## Visual Studio Code Config
- Plugins
    - 
- Themes
    - 
