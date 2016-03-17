#!/bin/sh

docker stop `docker ps -qa` ; docker rm `docker ps -qa`

exit 0