#!/bin/bash
set -e

if [ "$1" = 'freeswitch' ]; then

    chown -R root:freeswitch /etc/freeswitch
    chown -R root:freeswitch /var/{run,lib}/freeswitch

    exec gosu freeswitch /usr/bin/freeswitch -u freeswitch -g freeswitch -nonat -c
fi

exec "$@"