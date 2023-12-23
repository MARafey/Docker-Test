# Use an official Python runtime as the base image
FROM python:3.9

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install required system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory in the container
WORKDIR /app

# Copy requirements.txt to the working directory
COPY Requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r Requirements.txt

# Run command to download NLTK data
RUN python -c "import nltk; nltk.download('popular')"

# Copy the rest of the application's code
COPY . .

# Command to run when the container starts
CMD ["python", "svm.py"]
