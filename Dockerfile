FROM hidetarou2013/redmine:v3.3.0
MAINTAINER hide1227@gmail.com

ENV REDMINE_VERSION=3.3.0 \
    REDMINE_USER="redmine" \
    REDMINE_HOME="/home/redmine" \
    REDMINE_LOG_DIR="/var/log/redmine" \
    REDMINE_CACHE_DIR="/etc/docker-redmine" \
    RAILS_ENV=production

ENV REDMINE_INSTALL_DIR="${REDMINE_HOME}/redmine" \
    REDMINE_DATA_DIR="${REDMINE_HOME}/data" \
    REDMINE_BUILD_DIR="${REDMINE_CACHE_DIR}/build" \
    REDMINE_RUNTIME_DIR="${REDMINE_CACHE_DIR}/runtime" 

EXPOSE 80/tcp 443/tcp

VOLUME ["${REDMINE_DATA_DIR}", "${REDMINE_LOG_DIR}"]
WORKDIR ${REDMINE_INSTALL_DIR}
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["app:start"]
