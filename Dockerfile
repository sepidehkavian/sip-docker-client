FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git cmake build-essential \
    libasound2-dev libpulse-dev libavcodec-dev libavformat-dev libavutil-dev \
    libssl-dev libz-dev libopus-dev libv4l-dev \
    python3 python3-pip ffmpeg alsa-utils curl wget \
    && apt-get clean

WORKDIR /opt

# Clone and build re
RUN git clone https://github.com/baresip/re.git && \
    cd re && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build && cmake --install build

# Clone and build rem
RUN git clone https://github.com/baresip/rem.git && \
    cd rem && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build && cmake --install build

# Clone and build baresip
RUN git clone https://github.com/baresip/baresip.git && \
    cd baresip && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build && cmake --install build

RUN ldconfig

# Configs
RUN mkdir -p /root/.baresip
COPY config/ /root/.baresip/

# App
# Copy everything into app directory
COPY app/ /app/
COPY requirements.txt /app/
COPY output_sample.wav /app/

# Install dependencies
RUN pip3 install -r /app/requirements.txt

CMD bash -c "mkfifo /tmp/baresip_control && \
    baresip -f /root/.baresip < /tmp/baresip_control & \
    python3 /app/main.py & \
    python3 /app/ws_audio.py & \
    python3 /app/ws_audio_out.py"
