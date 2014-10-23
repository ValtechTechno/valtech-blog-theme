#!/bin/sh

echo "Build Wordpress for theme"
docker build -t wordpress-for-theme .

echo "Starting MySQL"
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql

echo "Starting Wordpress"
docker run --name some-wordpress --link some-mysql:mysql -d -v $(pwd)/theme/:/var/www/html/wp-content/themes/valtech/ wordpress-for-theme
