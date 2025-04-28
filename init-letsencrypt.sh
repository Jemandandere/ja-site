#!/bin/bash

domains=(jemandandere.com www.jemandandere.com jemandandere.ru www.jemandandere.ru)
rsa_key_size=4096
data_path="./certbot"
email="jemandandere@gmail.com" # Замените на ваш email

if [ -d "$data_path" ]; then
  read -p "Существующие данные certbot будут удалены. Продолжить? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    exit
  fi
fi

mkdir -p "$data_path/www"
mkdir -p "$data_path/conf"

docker compose -f docker-compose.prod.yml down

docker compose -f docker-compose.prod.yml up --force-recreate -d nginx

for domain in "${domains[@]}"; do
  docker compose -f docker-compose.prod.yml run --rm certbot certonly --webroot -w /var/www/certbot \
    --email $email \
    -d $domain \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal
done

docker compose -f docker-compose.prod.yml down 