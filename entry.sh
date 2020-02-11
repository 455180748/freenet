#!/usr/bin/env sh
if [ $DOMAIN ]; then
    acme.sh --issue -d $DOMAIN --standalone
    acme.sh --deploy -d $DOMAIN --deploy-hook docker
else
    echo there is no domain
    exit 1
fi

if [ "$1" = "daemon" ];  then
    trap "echo stop && killall crond && exit 0" SIGTERM SIGINT
    crond && while true; do sleep 1; done;
else
    exec -- "$@"
fi