# Using an older Ubuntu version (vulnerable)
FROM ubuntu:18.04

# Install some packages
RUN apt-get update && \
    apt-get install -y python3 curl wget vim && \
    rm -rf /var/lib/apt/lists/*

# Simple application
COPY app.py /app/app.py
WORKDIR /app

CMD ["python3", "app.py"]
