#!/bin/bash

domains=(jemandandere.com www.jemandandere.com jemandandere.ru www.jemandandere.ru)
rsa_key_size=4096
data_path="./certbot"
email="jemandandere@gmail.com"

if [ -d "$data_path" ]; then
  read -p "Существующие данные certbot будут удалены. Продолжить? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    exit
  fi
fi

# Остановка всех контейнеров
docker compose -f docker-compose.prod.yml down

# Создание необходимых директорий
mkdir -p "$data_path/www"
mkdir -p "$data_path/conf"

# Запуск только Nginx
docker compose -f docker-compose.prod.yml up --force-recreate -d nginx

# Ждем, пока Nginx полностью запустится
echo "Ожидание запуска Nginx..."
sleep 10

# Получение сертификатов
for domain in "${domains[@]}"; do
  echo "Запрос сертификата для $domain..."
  docker compose -f docker-compose.prod.yml run --rm certbot certonly --webroot -w /var/www/certbot \
    --email $email \
    -d $domain \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal \
    --non-interactive
done

# Проверка успешности получения сертификатов
if [ -d "$data_path/conf/live" ]; then
  echo "Сертификаты успешно получены!"
  # Запуск всех контейнеров
  docker compose -f docker-compose.prod.yml up -d
else
  echo "Ошибка при получении сертификатов. Проверьте логи для получения дополнительной информации."
  docker compose -f docker-compose.prod.yml down
  exit 1
fi 