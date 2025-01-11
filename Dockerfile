# Use a lightweight Python image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy project files into the container
COPY . /app

# Install system dependencies (no torrent-related packages)
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    libssl-dev \
    libcurl4-openssl-dev \
    && apt-get clean

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port if your bot uses a web server (adjust if necessary)
EXPOSE 8000

# Run the bot
CMD ["python3", "bot/bot.py"]
