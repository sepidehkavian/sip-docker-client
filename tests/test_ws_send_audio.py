import asyncio
import websockets

async def send_audio():
    uri = "ws://localhost:8086"
    async with websockets.connect(uri) as websocket:
        with open("tests/output_sample.wav", "rb") as f:
            data = f.read()
            await websocket.send(data)
        print("Audio sent!")

asyncio.run(send_audio())
