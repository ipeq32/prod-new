#!/bin/bash

# Scripti çalıştırma izni ver
if [ ! -x "$0" ]; then
    chmod +x "$0"
fi

CERTS_DIR="./production/nginx/certs"
WEBROOT_DIR="./production/www"

# Sertifika dizinini oluştur
if [ ! -d "$CERTS_DIR" ]; then
    mkdir -p "$CERTS_DIR"
    echo "Dizin oluşturuldu: $CERTS_DIR"
else
    echo "Dizin zaten mevcut: $CERTS_DIR"
fi

# Geçerli bir SSL sertifikası almak için Certbot'u webroot ile çalıştır
docker run -it --rm \
    -v "$CERTS_DIR:/etc/letsencrypt/live/kshup.com" \
    -v "$WEBROOT_DIR:/var/www/certbot" \
    certbot/certbot certonly \
    --webroot \
    --webroot-path /var/www/certbot \
    -d kshup.com -d www.kshup.com -d deneme.kshup.com \
    --non-interactive --agree-tos \
    --email tnhnipek@gmail.com

# Docker'ı başlat
docker compose up --build -d
