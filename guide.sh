nano /Users/ja/.ssh/known_hosts

ssh root@45.143.203.42

sudo apt update && sudo apt upgrade -y
sudo apt install -y git nginx curl npm

git clone https://github.com/once-ui-system/magic-portfolio.git /var/www/jemandandere
cd /var/www/jemandandere
npm install
npm run build

# До этого момента точно работает


#sudo npm install -g pm2
#pm2 start "npm run start" --name jemandandere
#pm2 save
#pm2 startup


sudo nano /etc/nginx/sites-available/jemandandere
server {
    listen 80;
    server_name jemandandere.com www.jemandandere.com jemandandere.ru www.jemandandere.ru;

    location / {
        proxy_pass http://localhost:3000;  # Порт Next.js
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

sudo ln -s /etc/nginx/sites-available/jemandandere /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx

sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d jemandandere.com -d www.jemandandere.com -d jemandandere.ru -d www.jemandandere.ru