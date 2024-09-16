
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy SSL certificates (self-signed for testing purposes)
COPY ./ssl/nginx.crt /etc/ssl/certs/nginx.crt
COPY ./ssl/nginx.key /etc/ssl/private/nginx.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
