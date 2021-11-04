#!/bin/env bash

mkdir -p ~/public_html
cp ./../info.php ~/public_html/info.php

sudo apt install php php-fpm php-cli php-mysql php-zip php-xml \
     php-mbstring php-curl php-intl php-mongodb php-bcmath php-gd \
     php-sqlite3

sudo cp ./../nginx/nginx.conf /etc/nginx/nginx.conf

sudo cp ./../nginx/default /etc/nginx/sites-enabled/default

sudo nginx -s reload
