# NGINX 기본 이미지를 기반으로 함
FROM nginx:latest

# netcat 설치
RUN apt-get update && apt-get install -y netcat-openbsd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# NGINX 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf

# SSL 인증서 및 키 파일 설정
RUN mkdir -p /etc/nginx/ssl && \
    printf "%s\n" "$SSL_CERT_KEY" > /etc/nginx/ssl/selfsigned.key && \
    printf "%s\n" "$SSL_CERT_CRT" > /etc/nginx/ssl/selfsigned.crt && \
    chmod 600 /etc/nginx/ssl/selfsigned.key && \
    chmod 600 /etc/nginx/ssl/selfsigned.crt && \
    chown root:root /etc/nginx/ssl/selfsigned.key /etc/nginx/ssl/selfsigned.crt

# 대기 스크립트 복사
COPY ./utils/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

ENTRYPOINT ["/wait-for-it.sh"]

# NGINX 실행
CMD ["nginx", "-g", "daemon off;"]