FROM nginx:1.25-alpine
LABEL maintainer="andrej@example.com"
COPY index.html /usr/share/nginx/html/index.html