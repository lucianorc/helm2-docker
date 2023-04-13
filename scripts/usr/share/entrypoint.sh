#!/bin/ash

. /etc/profile

CMD="$@"
if [[ -z "$1" ]]; then
    exec "/bin/ash"
fi

helm $CMD