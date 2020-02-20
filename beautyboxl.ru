
server {
    listen 80;
    server_name beautyboxl.ru *.beautyboxl.ru;

    return 301 https://$host$request_uri;
}

server {
	listen 443 ssl http2;
	client_max_body_size 200m;
        http2_chunk_size             1500k;
	add_header X-Frame-Options "SAMEORIGIN";
	add_header X-XSS-Protection "1; mode=block";
	add_header X-Content-Type-Options "nosniff";
	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	ssl on;
        ssl_certificate /etc/nginx/ssl/beautyboxl.crt;
        ssl_certificate_key /etc/nginx/ssl/beautyboxl.key;
        #ssl_dhparam /etc/nginx/ssl/dhparam.pem;
        server_name beautyboxl.ru *.beautyboxl.ru;
        server_name_in_redirect off;
	access_log     /var/log/nginx/domains/beautyboxl.ru.access.log;
        error_log      /var/log/nginx/domains/beautyboxl.ru.error.log info;
	root /var/www/beautybox/public;
	
	index index.php index.html index.htm;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
        #auth_basic "Restricted Content";
        #auth_basic_user_file /var/www/beautybox/.htpasswd;
    }
    location /api {
        try_files $uri $uri/ /index.php?$query_string;
        #auth_basic "Restricted Content";
        #auth_basic_user_file /var/www/beautybox/.htpasswd;
    }
    location /broadcasting {
        try_files $uri $uri/ /index.php?$query_string;
        #auth_basic "Restricted Content";
        #auth_basic_user_file /var/www/beautybox/.htpasswd;
    }

    location ~ ^/public/.+\.(jpeg|jpg|JPG|JPEG|PNG|png|gif|bmp|ico|svg|tif|tiff|css|js|ttf|otf|webp|woff|woff2|csv|rtf|doc|docx|xls|xlsx|ppt|pptx|odf|odp|ods|odt|pdf|psd|ai|eot|eps|ps|zip|tar|tgz|gz|rar|bz2|7z|aac|m4a|mp3|mp4|ogg|wav|wma|3gp|avi|flv|m4v|mkv|mov|mpeg|mpg|wmv|exe|iso|dmg|swf|html|htm|HTML)$ {
        root           /var/www/beautybox;
        index index.html;
        add_header Pragma public;
        add_header Cache-Control "public";
        expires        max;
        break;
    }

    location /cabinet {
        access_log     /var/log/nginx/domains/beautyboxl.static.log;
        alias /var/www/beautybox-crm/dist/;
        proxy_cache_valid any 30d;
        add_header Cache-Control "must-revalidate, public, max-age=2592000";
        open_file_cache max=3000 inactive=120s;
        open_file_cache_valid 45s;
        open_file_cache_min_uses 2;
        open_file_cache_errors off;
        index index.html;
        try_files $uri $uri/ @nodejs;
    }
    location @nodejs {
        access_log     /var/log/nginx/domains/beautybox-crm.access.log;
        error_log      /var/log/nginx/domains/beautybox-crm.error.log info;
        proxy_pass http://127.0.0.1:3004;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { 
	access_log off;
	log_not_found off; 
	root /var/www/beautybox/public;
        try_files $uri $uri/ /index.php?$query_string;
	auth_basic "Restricted Content";
        auth_basic_user_file /var/www/beautybox/.htpasswd;
    }

    location = /sitemap.xml  { 
	access_log off;
	log_not_found off; 
	root /var/www/beautybox/public;
        try_files $uri $uri/ /index.php?$query_string;
	auth_basic "Restricted Content";
        auth_basic_user_file /var/www/beautybox/.htpasswd;
    }

    error_page 404 /index.php;

    location ~ \.php$ {
	root /var/www/beautybox/public;
	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
    }
}

