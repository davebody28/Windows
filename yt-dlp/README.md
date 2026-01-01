# Description

> [!IMPORTANT]
> Node.js needed
> [Download link](https://nodejs.org/)

> [!IMPORTANT]
> Uwaga przy wklejaniu adresów URL ponieważ pobiera całe playlisty

# yt-dlp PowerShell Audio Downloader

Zaawansowany skrypt PowerShell do pobierania **best audio z YouTube**
z automatyczną konwersją do **MP3**, metadanymi ID3, logami oraz
automatycznym pobieraniem yt-dlp i ffmpeg.

---

## ✨ Funkcje

- ✅ Best audio extraction (`bestaudio/best`)
- ✅ Konwersja do MP3 (najlepsza jakość VBR)
- ✅ Automatyczne ID3 + okładki
- ✅ Obsługa playlist / mixów / pojedynczych linków
- ✅ Równoległe pobieranie fragmentów (wysoka wydajność)
- ✅ Automatyczna instalacja / aktualizacja:
  - yt-dlp
  - ffmpeg
- ✅ Logi:
  - `logs/yt-dlp.log`
  - `logs/yt-dlp-errors.log`
- ✅ Archiwum – brak duplikatów (`archive.txt`)

---

## 📁 Struktura katalogów
``` 
yt-dlp/
│
├── yt-dlp.ps1
├── urls.txt
├── archive.txt
│
├── downloads/
│
├── logs/
│ ├── yt-dlp.log
│ └── yt-dlp-errors.log
│
└── bin/
├── yt-dlp.exe
└── ffmpeg.exe
```

---

## 🔗 urls.txt

Każdy URL w osobnej linii:
https://www.youtube.com/watch?v=VIDEO_ID

https://www.youtube.com/playlist?list=PLAYLIST_ID


⚠️ **Uwaga:**  
Jeśli URL zawiera `list=`, yt-dlp pobierze **całą playlistę / mix**.

---

## ▶ Jak uruchomić

### PowerShell (zalecane)

1. Otwórz PowerShell w katalogu projektu
2. Wpisz:

```powershell
powershell -ExecutionPolicy Bypass -File yt-dlp.ps1
```

📊 Output i logi

Skrypt jest zoptymalizowany pod szybki internet i mocny komputer

Równoległość dotyczy fragmentów (zgodnie z możliwościami yt-dlp)

Playlisty są pobierane w całości – używaj URL-i świadomie

🛠 Troubleshooting

Brak outputu → sprawdź logi w logs/

Błędy YouTube → zaktualizuj yt-dlp

Problemy z formatami → zainstaluj Node.js

📜 Licencja

Do użytku prywatnego / edukacyjnego.

---

# 5️⃣ Co dalej (opcjonalnie)

Jeśli chcesz, w kolejnym kroku mogę:
- zrobić **2 tryby**: single / playlist
- dodać **prawdziwą równoległość URL-i (PowerShell jobs)**
- dodać **tryb „music library” (artist/album/year)**
- dodać **konfig z pliku `.ini` / `.json`**

Powiedz tylko w którą stronę idziemy 🚀
