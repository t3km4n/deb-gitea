FROM debian:bullseye-slim

LABEL org.opencontainers.image.authors="t3km4n"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# set version for s6 overlay
ARG OVERLAY_VERSION="2.2.0.3"
ARG OVERLAY_ARCH="x86"

ENV APP_VERSION="1.19.3" \
    T3KM4N_APP_NAME="gitea" \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8

# add s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz /tmp

COPY ansible/ /tmp/ansible/

RUN tar -C / -xf /tmp/s6-overlay-${OVERLAY_ARCH}.tar.gz && \
    echo "**** install dependencies ****" && \
    apt update && \
    apt install -y ansible && \
    cd /tmp/ansible && \
    mkdir /etc/gitea && \
    echo "**** run ansible ****" && \
    ansible-playbook playbook.yml && \
    apt -y autoremove && \
    apt -y autoclean && \
    echo "**** run ansible cleanup ****" && \
    ansible-playbook post_install.yml && \
    apt remove -y ansible && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* /home/gitea/*

# copy local files
COPY root/ /
COPY config/ /etc/gitea/
RUN chown git:git /etc/gitea/app.ini

EXPOSE 2222 3000

ENTRYPOINT ["/init"]