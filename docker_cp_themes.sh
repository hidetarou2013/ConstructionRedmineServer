#!/bin/bash

# run shell
# docker_cp_themes.sh myredmine3

docker cp /vagrant/farend_basic.zip $1:/home/redmine/redmine/public/themes/farend_basic.zip
docker cp /vagrant/farend_fancy.zip $1:/home/redmine/redmine/public/themes/farend_fancy.zip
docker cp /vagrant/pepper.zip $1:/home/redmine/redmine/public/themes/pepper.zip
docker cp /vagrant/pixel-cookers.zip $1:/home/redmine/redmine/public/themes/pixel-cookers.zip
docker cp /vagrant/redmine-theme-gitmike-r7.zip $1:/home/redmine/redmine/public/themes/redmine-theme-gitmike-r7.zip

exit 0