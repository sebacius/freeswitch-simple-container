FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get dist-upgrade -y && \
apt-get install -y --no-install-recommends procps curl wget gnupg gnupg2 lsb-release dialog apt-utils net-tools sngrep ca-certificates && \
wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add - && \
echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list && \
echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list && \
apt-get update

# explicitly set user/group IDs
RUN groupadd -r freeswitch --gid=999 && useradd -r -g freeswitch --uid=999 freeswitch

# grab gosu for easy step-down from root
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	gosu nobody true

# make the "en_US.UTF-8" locale so freeswitch will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y --no-install-recommends freeswitch freeswitch-mod-console freeswitch-mod-sofia \
freeswitch-mod-commands freeswitch-mod-conference freeswitch-mod-db freeswitch-mod-dptools freeswitch-mod-hash \
freeswitch-mod-dialplan-xml freeswitch-mod-sndfile freeswitch-mod-native-file freeswitch-mod-tone-stream \
freeswitch-mod-say-en freeswitch-mod-event-socket

# Clean up
RUN apt-get autoremove

ADD conf /etc/freeswitch

COPY docker_start.sh /
ENTRYPOINT ["/docker_start.sh"]

# Open the container up to the world.
EXPOSE 5070/udp
EXPOSE 64600-64605/udp

CMD ["freeswitch"]