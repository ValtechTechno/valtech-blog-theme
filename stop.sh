#!/bin/sh

echo "Stopping Wordpress"
docker stop some-wordpress
docker rm some-wordpress

echo "Stopping MySQL"
docker stop some-mysql
docker rm some-mysql
