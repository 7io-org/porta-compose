#! /bin/bash

export NAMESERVER="$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}' | tr '\n' ' ' | sed 's/^ *\| *$//')"

envsubst '$NAMESERVER' < /resolver.conf.template > /etc/nginx/conf.d/resolver.conf

exec nginx -g "daemon off;"
