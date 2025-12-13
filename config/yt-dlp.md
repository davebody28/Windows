# yt-dlp
First download the engine, and then make the bash (*.bat) file.

## Audio Downloader
``` bash
@ECHO OFF
@cd dir
@cd engine
@cls
@TITLE Audio Downloader
@ECHO ----------------------------------------------------------------------------
@ECHO 				Checking for updates
@ECHO ----------------------------------------------------------------------------
@ECHO.
yt-dlp -U
@ECHO.
@ECHO.
@:script
@ECHO ----------------------------------------------------------------------------
@ECHO 				Script Running...
@ECHO ----------------------------------------------------------------------------
@ECHO.
@set /p url="Enter URL: "
@ECHO.
@ECHO ----------------------------------------------------------------------------
@ECHO 			Downloading and converting item...
@ECHO ----------------------------------------------------------------------------
yt-dlp -f bestaudio -o "C:\%HOMEPATH%\Music\Audio-Downloads\%%(title)s.%%(ext)s" -x --audio-format mp3 --audio-quality 0 %url%
@ECHO.
@ECHO ----------------------------------------------------------------------------
@ECHO Output file has been saved under path C:\%HOMEPATH%\Music\Audio-Downloads
@ECHO ----------------------------------------------------------------------------
@TIMEOUT /T 5
@:End
@cls
@CALL :script
```


## Video Downloader
``` bash
@ECHO OFF
@cd dir
@cd engine
@cls
@TITLE Video Downloader
@ECHO ----------------------------------------------------------------------------
@ECHO 				Checking for updates
@ECHO ----------------------------------------------------------------------------
@ECHO.
yt-dlp -U
@ECHO.
@ECHO.
@:script
@ECHO ---------------------------------------------------------------------------- 
@ECHO 				Script Running...
@ECHO ---------------------------------------------------------------------------- 
@ECHO.
@set /p url="Enter URL: "
@ECHO.
@ECHO ----------------------------------------------------------------------------
@ECHO 				Downloading item...
@ECHO ----------------------------------------------------------------------------
yt-dlp -f bestvideo -o "C:\%HOMEPATH%\Videos\Video-Downloads\%%(title)s.%%(ext)s" %url%
@ECHO.
@ECHO ----------------------------------------------------------------------------
@ECHO Output file has been saved under path C:\%HOMEPATH%\Videos\Video-Downloads
@ECHO ----------------------------------------------------------------------------
@TIMEOUT /T 10
@:End
@cls
@CALL :script
```


## Video Converter
``` bash
@ECHO ON
@cd dir
@cd engine
@IF NOT EXIST "C:\%HOMEPATH%\Videos\Converted" ( mkdir "C:\%HOMEPATH%\Videos\Converted" )
@cls
@TITLE Video Converter
@:script
@ECHO ---------------------------------------------------------------------------- 
@ECHO 				Script Running...
@ECHO ---------------------------------------------------------------------------- 
@ECHO.
@ECHO Select Source:
@pause
@set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
@set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
@set dialog=%dialog%close();resizeTo(0,0);</script>"
@for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
@cls
@ECHO ---------------------------------------------------------------------------- 
@ECHO 				Script Running...
@ECHO ---------------------------------------------------------------------------- 
@ECHO.
@ECHO Select output format:
@ECHO E.G: MP4 / MPEG / AVI
@set /p format=
@ECHO.
@ECHO ----------------------------------------------------------------------------
@ECHO 				Converting item...
@ECHO ----------------------------------------------------------------------------
ffmpeg -i %file% C:\%HOMEPATH%\Videos\Converted\video.%format%
@ECHO.
@ECHO ----------------------------------------------------------------------------
@ECHO Output file has been saved under path C:\%HOMEPATH%\Videos\Converted
@ECHO ----------------------------------------------------------------------------
@TIMEOUT /T 10
@:End
@cls
@CALL :script
```


## Video Player
``` bash
@ECHO ON
@cd dir
@cd engine
@cls
@TITLE Video Player
@:script
@ECHO ---------------------------------------------------------------------------- 
@ECHO 				Script Running...
@ECHO ---------------------------------------------------------------------------- 
@ECHO.
@ECHO Select Source:
@pause
@set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
@set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
@set dialog=%dialog%close();resizeTo(0,0);</script>"
@for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
@ECHO.
@ECHO ----------------------------------------------------------------------------
@ECHO 				Playing video...
@ECHO ----------------------------------------------------------------------------
ffplay -i %file% -fs
@ECHO.
@pause
@:End
@cls
@CALL :script
```