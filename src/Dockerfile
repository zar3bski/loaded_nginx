FROM nginx:1.17.1-alpine 
MAINTAINER David Zarebski <zarebskidavid@gmail.com>

WORKDIR /usr/src/nginx

ENV DOMAIN_NAME my.domain.com
ENV LOGIN_URL /admin
ENV STATICFILES_URL /some/url/to/check
ENV TO_CONTAINER some_container:80

RUN apk update \
	&& apk add certbot certbot-nginx fail2ban

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.template
COPY ./entrypoint.sh /usr/src/nginx/entrypoint.sh

ENTRYPOINT ["/usr/src/nginx/entrypoint.sh"]
