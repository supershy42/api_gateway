# NGINX 기본 이미지를 기반으로 함
FROM nginx:latest

# netcat 설치
RUN apt-get update && apt-get install -y netcat-openbsd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# NGINX 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf

# 대기 스크립트 복사
COPY ./utils/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

ENTRYPOINT ["/wait-for-it.sh"]

# NGINX 실행
CMD ["nginx", "-g", "daemon off;"]