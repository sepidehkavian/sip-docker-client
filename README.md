
# 📞 SIP-Docker-Client

Ein vollständiger SIP-Client in Docker, gesteuert über REST und WebSocket – ohne zusätzliche Hardware!

---

## ✅ Funktionen

- **SIP-Anmeldung** bei einem SIP-Provider (getestet mit [Linphone](https://www.linphone.org))
- **REST-API** zum Starten von Anrufen: `POST /call`
- **Audioübertragung via WebSocket**
  - 🎙️ Port 8086 – Audio IN (Mikrofon)
  - 🔊 Port 8087 – Audio OUT (Wiedergabe)
- **Volle Kontrolle ohne WebRTC** (keine Browserabhängigkeit!)
- Funktioniert **komplett in Docker**

---

## 📁 Projektstruktur

```
.
├── app/
│   ├── main.py             # REST-API zum Anrufstart
│   ├── ws_audio.py         # WebSocket-Eingang (8086)
│   └── ws_audio_out.py     # WebSocket-Ausgang (8087)
├── config/
│   ├── accounts            # SIP-Zugangsdaten
│   ├── config              # baresip-Konfiguration
│   └── contacts            # Kontakteinträge
├── .env                    # Umgebungsvariablen für Zugangsdaten
├── docker-compose.yml      # Container-Start
├── Dockerfile              # Build-Anweisungen
├── requirements.txt        # Python-Abhängigkeiten
└── README.md               # Diese Datei
```

---

## ⚙️ Voraussetzungen

- 🐳 [Docker](https://www.docker.com/)
- 📦 [Docker Compose](https://docs.docker.com/compose/)

---

## 🔧 Konfiguration

### 1. `.env` Datei erstellen

Erstelle im Projektverzeichnis eine `.env` Datei mit folgendem Inhalt:

```env
SIP_DOMAIN=sip.linphone.org
USERNAME=sepet
PASSWORD=Sk7975097?
```

### 2. baresip-Konfiguration anpassen

Die Datei `config/config` muss absolute Pfade zu den baresip-Modulen enthalten (z. B.):

```
module /usr/local/lib/baresip/modules/stdio.so
module /usr/local/lib/baresip/modules/sip.so
module /usr/local/lib/baresip/modules/tls.so
...
```

---

## 🚀 Anwendung starten

```bash
docker compose build --no-cache
docker compose up
```

---

## 📞 Anruf starten

```bash
curl -X POST http://localhost:8085/call \
  -H "Content-Type: application/json" \
  -d '{"number": "sip:dochi@sip.linphone.org"}'
```

---

## 🎧 Audio testen

### WebSocket Audio senden (Port 8086)

```bash
python3 test_ws_send_audio.py
```

### WebSocket Audio empfangen (Port 8087)

```bash
python3 test_ws_recv_audio.py
```

> 📌 Hinweis: Die Datei `output_sample.wav` wird im Container abgespielt. Du kannst sie durch eine eigene WAV-Datei ersetzen.

---

## 🛠 Hinweise

- baresip wurde **aus dem Source kompiliert**, um volle Kontrolle über Module zu haben.
- Die Module werden **manuell mit absoluten Pfaden geladen**
- Kein Zugriff auf Host-Hardware notwendig
- Keine Verwendung von WebRTC oder Browserabhängigkeit

---

## 🧹 Optional: .gitignore

Wenn du bestimmte Dateien nicht in Git pushen willst, kannst du eine `.gitignore` Datei anlegen mit z. B.:

```
*.wav
*.aiff
test_ws_*.py
Dockerfile.test
```

---

## 🔊 Test-Audio (optional)

WAV-Datei herunterladen:

```bash
curl -o output_sample.wav https://file-examples.com/storage/fe4b0be9e6b74d6a69e80b0/2017/11/file_example_WAV_1MG.wav
```

