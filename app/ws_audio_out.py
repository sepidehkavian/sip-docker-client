# app/ws_audio_out.py

import asyncio
import websockets

AUDIO_FILE_PATH = "/app/output_sample.wav"

async def audio_output(websocket):
    print("WebSocket 8087 connected")
    try:
        with open(AUDIO_FILE_PATH, "rb") as f:
            data = f.read()
            await websocket.send(data)
            print("Audio sent to client.")
    except Exception as e:
        print("Error:", e)

async def main():
    print("WebSocket output server running on port 8087...")
    async with websockets.serve(audio_output, "0.0.0.0", 8087):
        await asyncio.Future()

if __name__ == "__main__":
    asyncio.run(main())
