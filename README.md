# SIP-Docker-Client

Dieses Projekt demonstriert einen Docker-basierten SIP-Client mit folgenden Funktionen:

- ✅ **SIP-Anmeldung** bei einem SIP-Provider (getestet mit [Linphone](https://www.linphone.org))
- ✅ **Ausgehende Anrufe** via REST-API (`POST /call`)
- ✅ **Audioübertragung** über WebSocket
  - **Port 8086**: Eingang (Audio empfangen)
  - **Port 8087**: Ausgang (Audio senden)
- ✅ Funktioniert **ohne spezielle Hardware** – komplett in Docker!

---

## 📁 Projektstruktur



. ├── app/ │ ├── main.py # REST-API zum Starten von Anrufen │ ├── ws_audio.py # WebSocket-Server zum Empfangen von Audio (8086) │ └── ws_audio_out.py # WebSocket-Server zum Senden von Audio (8087) ├── config/ │ ├── accounts # SIP-Zugangsdaten │ ├── config # baresip Konfiguration │ └── contacts # SIP-Kontakte ├── .env # SIP-Zugangsdaten als Umgebungsvariablen ├── docker-compose.yml # Start des Containers ├── Dockerfile # Dockerfile zur Erstellung des Images ├── requirements.txt # Python-Abhängigkeiten └── README.md # Diese Datei


---

## ⚙️ Voraussetzungen

- 🐳 [Docker](https://www.docker.com/)
- 📦 [Docker Compose](https://docs.docker.com/compose/)

---

## 🧪 Konfiguration

### 1. `.env` Datei erstellen

Lege im Projektverzeichnis eine `.env` Datei an:

```env
SIP_DOMAIN=sip.linphone.org
USERNAME=sepet
PASSWORD=Sk7975097?


Starten:
docker compose build --no-cache
docker compose up


 REST-API zum Anrufen:
 curl -X POST http://localhost:8085/call \
  -H "Content-Type: application/json" \
  -d '{"number": "sip:dochi@sip.linphone.org"}'



WebSocket Audio Test:

Audio senden (an Port 8086):
python3 test_ws_send_audio.py


Audio empfangen (von Port 8087):
python3 test_ws_recv_audio.py


Alle WebSocket-Tests wurden lokal mit sample.wav getestet. Die Datei wird im Docker-Container abgespielt oder gespeichert. Du kannst eigene WAV-Dateien testen, indem du sample.wav ersetzt.

Hinweise
🛠 baresip wurde aus Source gebaut, damit alle Module vorhanden sind.

🔒 Kein Zugriff auf Host-Hardware notwendig.

🚫 Kein WebRTC (wie SIP.js) – volle Kontrolle via baresip.

📂 config/config verwendet absolute Pfade für Module z.B.:

module /usr/local/lib/baresip/modules/sip.so
module /usr/local/lib/baresip/modules/tls.so


📎 Tipps
Wenn *.wav oder test_ws_*.py nicht mehr gebraucht werden, kannst du sie mit .gitignore ausschließen.

Wenn du testen willst, kannst du z. B. einen WAV-Testfile so holen:
curl -o sample.wav https://file-examples.com/storage/fe4b0be9e6b74d6a69e80b0/2017/11/file_example_WAV_1MG.wav



