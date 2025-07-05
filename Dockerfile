# Use official Python slim image
FROM python:3.11-slim-bullseye

# Prevent writing .pyc files and enable unbuffered stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy your app source code
COPY requirements.txt .
# Upgrade pip and install Python dependencies
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Set working directory
WORKDIR /app

# Command to run your Streamlit app
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
