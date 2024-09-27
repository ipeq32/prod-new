#!/bin/bash

# Scripti çalıştırma izni ver
if [ ! -x "$0" ]; then
    chmod +x "$0"
fi

CERTS_DIR="./production/nginx/certs"

# Sertifika dizinini oluştur
if [ ! -d "$CERTS_DIR" ]; then
    mkdir -p "$CERTS_DIR"
    echo "Dizin oluşturuldu: $CERTS_DIR"
else
    echo "Dizin zaten mevcut: $CERTS_DIR"
fi

# Geçerli bir SSL sertifikası almak için Certbot'u çalıştır
docker run -it --rm \
    -v "$CERTS_DIR:/etc/letsencrypt/live/kshup.com" \
    certbot/certbot certonly \
    --standalone \
    --preferred-challenges http \
    -d kshup.com -d www.kshup.com \
    --non-interactive --agree-tos \
    --email tnhnipek@gmail.com

# Docker'ı başlat
docker compose up --build -d
