# Jemandandere.com

Персональный сайт, построенный на Next.js с использованием Docker для локальной разработки и продакшена.

## Требования

- Docker (версия 20.10.0 или выше)
- Docker Compose (версия 2.0.0 или выше)
- Git
- Node.js (для локальной разработки)

### Установка Docker и Docker Compose

#### Ubuntu/Debian:

```bash
# Удаление старых версий
sudo apt-get remove docker docker-engine docker.io containerd runc

# Установка необходимых пакетов
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Добавление официального GPG-ключа Docker
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Настройка репозитория
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Установка Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Установка Docker Compose
sudo apt-get update
sudo apt-get install docker-compose-plugin

# Проверка установки
docker --version
docker compose version
```

#### macOS:

```bash
# Установка через Homebrew
brew install docker docker-compose

# Или скачайте Docker Desktop с официального сайта:
# https://www.docker.com/products/docker-desktop
```

## Клонирование репозитория

```bash
git clone https://github.com/Jemandandere/ja-site.git
cd ja-site
```

## Локальная разработка

1. Запустите контейнеры в режиме разработки:
```bash
docker compose -f docker-compose.dev.yml up
```

2. Откройте [http://localhost:3000](http://localhost:3000) в браузере

В режиме разработки:
- Node.js приложение доступно на порту 3000
- Nginx доступен на порту 80
- Включен hot-reload для автоматического обновления при изменении кода
- Режим разработки (development)

## Продакшен развертывание

1. Настройка SSL-сертификатов:
```bash
# Отредактируйте email в init-letsencrypt.sh
./init-letsencrypt.sh
```

2. Запуск в продакшен режиме:
```bash
docker compose -f docker-compose.prod.yml up -d
```

В продакшен режиме:
- Node.js приложение доступно только внутри Docker network
- Nginx доступен на портах 80 и 443
- Включен Certbot для SSL
- Режим продакшена

## Структура проекта

```
.
├── docker-compose.dev.yml    # Конфигурация для локальной разработки
├── docker-compose.prod.yml   # Конфигурация для продакшена
├── init-letsencrypt.sh      # Скрипт настройки SSL
├── nginx/                   # Конфигурация Nginx
│   └── nginx.conf
└── node/                    # Next.js приложение
    ├── src/
    ├── public/
    └── ...
```

## Обновление сайта

1. Внесите изменения в код
2. Зафиксируйте изменения:
```bash
git add .
git commit -m "Описание изменений"
git push
```

3. На сервере:
```bash
git pull
docker compose -f docker-compose.prod.yml up -d --build
```

## Устранение неполадок

### Ошибка с Docker Compose

Если вы видите ошибку:
```
Error while fetching server API version: HTTPConnection.request() got an unexpected keyword argument 'chunked'
```

Это означает, что у вас установлена устаревшая версия Docker Compose. Выполните следующие шаги:

1. Удалите старую версию:
```bash
sudo apt-get remove docker-compose
```

2. Установите новую версию:
```bash
sudo apt-get update
sudo apt-get install docker-compose-plugin
```

3. Используйте команду `docker compose` вместо `docker-compose`

## Поддержка

Если у вас возникли проблемы или есть вопросы, создайте issue в репозитории. 