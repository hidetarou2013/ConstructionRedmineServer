#!/bin/sh

docker-compose stop
docker-compose rm -f
docker ps -a

exit 0