#!/bin/bash

check_service() {
    HOST=$1
    PORT=$2
    echo "Waiting for $HOST:$PORT..."
    while ! nc -z $HOST $PORT; do
    sleep 1
    done
    echo "$HOST:$PORT is available!"
}

# Wait for multiple services
check_service user 8000
check_service game 8000
check_service chat 8000
# check_service frontend 3000 악의 원흉

exec "$@"