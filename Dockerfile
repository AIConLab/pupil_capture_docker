FROM python:3.8-slim-buster

ENV DEBIAN_FRONTEND=noninteractive
# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    libusb-1.0-0 \
    libportaudio2 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libglib2.0-0 \
    libglfw3 \
    libglew2.1 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libxcomposite1 \
    x11-apps \
    mesa-utils \
    libopengl0 \
    libglx-mesa0 \
    libglu1-mesa \
    xvfb \
    xauth \
    && rm -rf /var/lib/apt/lists/*
# Create plugdev group and user
RUN groupadd -f -r plugdev && useradd -m -r -g plugdev pupiluser
# Clone specific commit of Pupil repository
RUN git clone https://github.com/jc-cr/pupil.git /app/pupil \
    && cd /app/pupil \
    && git checkout 04695b42b8e65b563d6127943720488f016664db
# Set ownership of the cloned repository to pupiluser
RUN chown -R pupiluser:plugdev /app/pupil
WORKDIR /app/pupil
# Install Python dependencies
RUN python3 -m pip install --no-cache-dir -r requirements.txt
# Set up USB access
RUN mkdir -p /etc/udev/rules.d && \
    echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", GROUP="plugdev", MODE="0664"' > /etc/udev/rules.d/10-libuvc.rules
# Set environment variables
ENV PYTHONPATH=/app/pupil
ENV LIBGL_ALWAYS_INDIRECT=0
# Switch to pupiluser
USER pupiluser
# Set the working directory to pupil_src
WORKDIR /app/pupil/pupil_src
# Add a script to start the application
RUN echo '#!/bin/bash\npython3 main.py capture' > /app/pupil/pupil_src/start.sh && \
    chmod +x /app/pupil/pupil_src/start.sh