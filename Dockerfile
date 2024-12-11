# NGINX 기본 이미지를 기반으로 함
FROM nginx:latest

# NGINX 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf

# NGINX 실행
CMD ["nginx", "-g", "daemon off;"]