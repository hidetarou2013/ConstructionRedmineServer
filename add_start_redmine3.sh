#!/bin/bash

# run shell
# add_start_redmine3.sh myredmine3

#docker run --name=$1 -d -t -p 10080:80 --link $1_mysql:mysql --link $1_svn:svn --volumes-from $1_redmine_storage sameersbn/redmine
docker stop $1
docker rm $1
docker run --name=$1 -d -t -p 10080:80 --link $1_mysql:mysql --link $1_svn:svn --volumes-from $1_redmine_storage hidetarou2013/redmine:v3.3.0_a

# status check
docker ps -a
sleep 2s
docker ps

exit 0