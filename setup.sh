#!/bin/bash

# Scripti çalıştırma izni ver
if [ ! -x "$0" ]; then
    chmod +x "$0"
fi

CERTS_DIR="./production/nginx/certs"
WEBROOT_DIR="./production/nginx/www"

# Sertifika dizinini oluştur
if [ ! -d "$CERTS_DIR" ]; then
    mkdir -p "$CERTS_DIR"
    echo "Dizin oluşturuldu: $CERTS_DIR"
else
    echo "Dizin zaten mevcut: $CERTS_DIR"
fi

# Webroot dizinini oluştur
if [ ! -d "$WEBROOT_DIR" ]; then
    mkdir -p "$WEBROOT_DIR"
    echo "Dizin oluşturuldu: $WEBROOT_DIR"
else
    echo "Dizin zaten mevcut: $WEBROOT_DIR"
fi

# Docker'ı başlat
docker compose up --build -d
