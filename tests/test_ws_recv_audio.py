import asyncio
import websockets
import os

OUTPUT_FILE = "tests/received_output.wav"

async def recv_audio():
    uri = "ws://localhost:8087"
    async with websockets.connect(uri) as websocket:
        print("Connected to WebSocket, waiting for audio...")
        with open(OUTPUT_FILE, "wb") as f:
            while True:
                try:
                    message = await websocket.recv()
                    if isinstance(message, bytes):
                        f.write(message)
                    else:
                        break
                except:
                    break
        print("Received audio. Saved as", OUTPUT_FILE)

asyncio.run(recv_audio())
