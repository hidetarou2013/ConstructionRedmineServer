#!/bin/sh

docker stop `docker ps -qa` ; docker rm `docker ps -qa`
docker ps -a

exit 0