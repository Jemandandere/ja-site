#!/bin/bash

echo "Проверка SSL-сертификатов..."

# Проверка наличия сертификатов
if [ -f "/etc/letsencrypt/live/jemandandere.com/fullchain.pem" ]; then
    echo "✅ Сертификат fullchain.pem найден"
else
    echo "❌ Сертификат fullchain.pem не найден"
fi

if [ -f "/etc/letsencrypt/live/jemandandere.com/privkey.pem" ]; then
    echo "✅ Сертификат privkey.pem найден"
else
    echo "❌ Сертификат privkey.pem не найден"
fi

# Проверка прав доступа
echo "Проверка прав доступа к сертификатам..."
ls -l /etc/letsencrypt/live/jemandandere.com/

# Проверка конфигурации Nginx
echo "Проверка конфигурации Nginx..."
docker compose -f docker-compose.prod.yml exec nginx nginx -t

# Проверка SSL-соединения
echo "Проверка SSL-соединения..."
openssl s_client -connect jemandandere.ru:443 -servername jemandandere.ru 