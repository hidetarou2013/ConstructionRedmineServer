#!/bin/bash

# run shell
# sh add_start_redmine3.sh myredmine3 10080 v3.3.0_c
# param1:container name
# param2:redmine port
# param3:docker image tag

#docker run --name=$1 -d -t -p $2:80 --link $1_mysql:mysql --link $1_svn:svn --volumes-from $1_redmine_storage sameersbn/redmine
docker stop $1
docker rm $1
docker run --name=$1 -d -t -p $2:80 --link $1_mysql:mysql --link $1_svn:svn --volumes-from $1_redmine_storage hidetarou2013/redmine:$3

# status check
docker ps -a
sleep 2s
docker ps

exit 0