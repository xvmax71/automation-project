#!/bin/bash

apk update
apk add nano

mkdir wordpress
cd wordpress/

cat <<EOF >> docker-compose.yml
version: '3'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: your_mysql_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: 123

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - 8081:80
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: 123

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    links:
      - db:mysql
    ports:
      - 8080:80
    environment:
      PMA_HOST: db
      PMA_PORT: 3306
      MYSQL_ROOT_PASSWORD: 123

volumes:
  db_data:
EOF

# Start the containers
docker-compose up -d
