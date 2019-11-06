FROM nginx:1.17.1-alpine 
MAINTAINER David Zarebski <zarebskidavid@gmail.com>

WORKDIR /usr/src/nginx

ENV DOMAIN_NAME my.domain.com
ENV ADMIN_EMAIL my@adress.com
ENV LOGIN_URL /admin
ENV STATICFILES_URL /some/url/to/check
ENV TO_CONTAINER some_container:80
ENV CSP_DEFAULT "'self' "
ENV CSP_SCRIPT "'self' "
ENV CSP_STYLE "'self' "
ENV CSP_IMG "'self' "
ENV CSP_CONNECT "'self' "
ENV CSP_FONT "'self' fonts.googleapis.com"
ENV CSP_OBJECT "'self' "
ENV CSP_MEDIA "'self' "
ENV CSP_FRAME "'self' https://www.google.com https://www.youtube.com https://www.facebook.com"
ENV X_FRAME SAMEORIGIN
ENV HTTPS True

RUN apk update \
	&& apk add certbot certbot-nginx rsyslog fail2ban

RUN rm /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/nginx.conf

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./site.conf /etc/nginx/conf.template
COPY ./entrypoint.sh /usr/src/nginx/entrypoint.sh

ENTRYPOINT ["/usr/src/nginx/entrypoint.sh"]
