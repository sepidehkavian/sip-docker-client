FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git cmake build-essential \
    libasound2-dev libpulse-dev libavcodec-dev libavformat-dev libavutil-dev \
    libssl-dev libz-dev libopus-dev libv4l-dev \
    python3 python3-pip ffmpeg \
    alsa-utils pulseaudio curl wget \
    && apt-get clean

# Build libre
WORKDIR /opt
RUN git clone https://github.com/baresip/re.git && \
    cd re && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build && cmake --install build

# Build librem
RUN git clone https://github.com/baresip/rem.git && \
    cd rem && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build && cmake --install build

# Build baresip
RUN git clone https://github.com/baresip/baresip.git && \
    cd baresip && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build && cmake --install build

# Make sure libs load
RUN ldconfig

# Copy configs
RUN mkdir -p /root/.baresip
COPY config/ /root/.baresip/

# Copy app
COPY app/ /app/
COPY output_sample.wav /app/
RUN pip3 install flask websockets

CMD bash -c "mkfifo /tmp/baresip_control && \
    baresip -f /root/.baresip < /tmp/baresip_control & \
    python3 /app/main.py & \
    python3 /app/ws_audio.py & \
    python3 /app/ws_audio_out.py"
