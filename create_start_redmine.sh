#!/bin/bash

# pull method
docker pull hidetarou2013/redmine-storage:latest 
docker pull hidetarou2013/mysql-storage:latest 
#docker pull hidetarou2013/svn-storage:latest 
docker pull sameersbn/redmine:latest 
docker pull sameersbn/mysql:latest

# build method
#docker build -t sameersbn/mysql github.com/sameersbn/docker-mysql
#docker build -t sameersbn/redmine github.com/sameersbn/docker-redmine
#docker build -t hidetarou2013/mysql-storage github.com/hidetarou2013/mysql-storage
#docker build -t hidetarou2013/redmine-storage github.com/hidetarou2013/redmine-storage
#docker build -t hidetarou2013/svn-storage github.com/hidetarou2013/svn-storage

docker create --name myredmine1_redmine_storage hidetarou2013/redmine-storage
docker create --name myredmine1_mysql_storage hidetarou2013/mysql-storage
docker run --volumes-from myredmine1_mysql_storage --name=myredmine1_mysql -d -e 'DB_NAME=redmine_production'  -e 'DB_USER=redmine' -e 'DB_PASS=password' sameersbn/mysql:latest

# svn
#docker create --name svn-storage hidetarou2013/svn-storage
#docker run --volumes-from svn-storage --name myredmine1_svn -t -d -v /home/vagrant/web-contents/:/var/www/html/ -p 80:80 -p 443:443 hidetarou2013/centos6-apache:SVN_repo1
docker run --name myredmine1_svn -t -d -v /home/vagrant/web-contents/:/var/www/html/ -p 80:80 -p 443:443 hidetarou2013/centos6-apache:SVN_repo1

#docker run --name=redmine -it --rm -p 10080:80 --link myredmine1_mysql:mysql --volumes-from redmine-storage sameersbn/redmine
#docker run --name=redmine -d -t -p 10080:80 --link myredmine1_mysql:mysql --volumes-from redmine-storage sameersbn/redmine
docker run --name=myredmine1 -d -t -p 10080:80 --link myredmine1_mysql:mysql --link myredmine1_svn:svn --volumes-from myredmine1_redmine_storage sameersbn/redmine

# status check
docker ps -a
sleep 2s
docker ps

exit 0