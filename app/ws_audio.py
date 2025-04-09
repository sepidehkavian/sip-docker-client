import asyncio
import websockets
import os

AUDIO_FILE_PATH = "/tmp/incoming_audio.wav"

# Remove old audio file if it exists
if os.path.exists(AUDIO_FILE_PATH):
    os.remove(AUDIO_FILE_PATH)

async def audio_input(websocket):
    print("WebSocket 8086 connected")
    try:
        with open(AUDIO_FILE_PATH, "wb") as f:
            async for message in websocket:
                if isinstance(message, bytes):
                    f.write(message)
        print("Audio file received.")
        os.system(f"aplay {AUDIO_FILE_PATH}")  # Play the audio inside the container
    except Exception as e:
        print("Error:", e)

async def main():
    print("WebSocket audio input listening on 8086...")
    async with websockets.serve(audio_input, "0.0.0.0", 8086, max_size=None):
        await asyncio.Future()  # Run forever

if __name__ == "__main__":
    asyncio.run(main())
