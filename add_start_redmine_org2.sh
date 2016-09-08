#!/bin/bash

#docker run --name=myredmine2 -d -t -p 10080:80 --link myredmine2_mysql:mysql --link myredmine2_svn:svn --volumes-from myredmine2_redmine_storage sameersbn/redmine
docker stop myredmine2
docker rm myredmine2
docker run --name=myredmine2 -d -t -p 10080:80 --link myredmine2_mysql:mysql --link myredmine2_svn:svn --volumes-from myredmine2_redmine_storage hidetarou2013/redmine:v3.3.0_a

# status check
docker ps -a

exit 0