#!/bin/sh

# SSL 디렉토리 생성
SSL_DIR="/etc/nginx/ssl"
mkdir -p "$SSL_DIR"

# SSL 키와 인증서 생성
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$SSL_DIR/selfsigned.key" \
    -out "$SSL_DIR/selfsigned.crt" \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=GAM/CN=spark2.42.fr"

# 키와 인증서 권한 설정
chmod 600 "$SSL_DIR/selfsigned.key" "$SSL_DIR/selfsigned.crt"
chown root:root "$SSL_DIR/selfsigned.key" "$SSL_DIR/selfsigned.crt"

echo "SSL key and certificate generated successfully."

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