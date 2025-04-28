# Jemandandere.com

Персональный сайт, построенный на Next.js с использованием Docker для локальной разработки и продакшена.

## Требования

- Docker
- Docker Compose
- Git
- Node.js (для локальной разработки)

## Клонирование репозитория

```bash
git clone https://github.com/Jemandandere/ja-site.git .
```

## Локальная разработка

1. Запустите контейнеры в режиме разработки:
```bash
docker-compose -f docker-compose.dev.yml up
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
docker-compose -f docker-compose.prod.yml up -d
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
docker-compose -f docker-compose.prod.yml up -d --build
```

## Поддержка

Если у вас возникли проблемы или есть вопросы, создайте issue в репозитории. 