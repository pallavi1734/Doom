# Use a lightweight Python image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Install necessary packages including qBittorrent-nox
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    aria2 \
    qbittorrent-nox \
    && apt-get clean

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that your bot will use (adjust if necessary)
EXPOSE 8000

# Start qBittorrent-nox in the background
RUN mkdir -p /root/.config/qBittorrent
COPY qbittorrent.conf /root/.config/qBittorrent/qBittorrent.conf
CMD qbittorrent-nox &

# Start the bot
CMD ["python3", "bot/bot.py"]
