# NGINX 기본 이미지를 기반으로 함
FROM nginx:latest

# netcat 설치
RUN apt-get update \
    && apt-get install -y netcat-openbsd nginx openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# NGINX 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf
COPY cors-headers.conf /etc/nginx/common/cors-headers.conf
COPY var/www/media/avatars var/www/media/avatars
RUN chmod -R 755 /var/www/media/avatars

# Nginx 초기화 스크립트 복사 및 실행 권한 부여
COPY ./utils/init_nginx.sh /init_nginx.sh
RUN chmod +x /init_nginx.sh

ENTRYPOINT ["/init_nginx.sh"]

# NGINX 실행
CMD ["nginx", "-g", "daemon off;"]