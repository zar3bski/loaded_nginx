# Nginx Cerberus Proxy

![](https://img.shields.io/docker/cloud/automated/zar3bski/nginx_cerberus.svg)
![](https://img.shields.io/docker/cloud/build/zar3bski/nginx_cerberus.svg)
![](https://images.microbadger.com/badges/image/zar3bski/nginx_cerberus.svg)
![](https://img.shields.io/github/v/release/zar3bski/nginx_cerberus)


A custom Nginx proxy pass image for the typical web application. Covers most simple needs 

## Features

* fail2ban: creation of a filter based on the `LOGIN_URL` env provided
* static files serving
* HTTPS with certbot
* [Content Security Policy](https://developer.mozilla.org/fr/docs/Web/HTTP/CSP). The execution of inline scripts is disabled by default but could be allowed by overriding CSP environnement variables (see below)

### Limitations

* one to one proxy (only one web application)
* no url rewriting (ressources mentionned in the application should have the right domain name)
* if `HTTPS`, a certificate will be initiated at container startup. That means that the container shoud be instanciated with [Let's Encrypt rate limits](https://letsencrypt.org/fr/docs/rate-limits/) in mind


## Env variables

Any of these variables could be overrided to change the container's behavior

| variable name  | description                                              | default value     |
|---------------:|:---------------------------------------------------------|:-----------------:|
| DOMAIN_NAME    | domain name of your application                          | my.domain.com     |
| LOGIN_URL      | login url of the application (fail2ban)                  | /admin            |
| STATICFILES_URL| root url of static files that Nginx should serve         | /some/url/to/check|
| TO_CONTAINER   | container: port that Nginx should pass the connection to | some_container:80 |
| CSP_DEFAULT    |                                                          | "'self' "         |
| CSP_SCRIPT     |                                                          | "'self' "         |
| CSP_STYLE      |                                                          | "'self' "         |
| CSP_IMG        |                                                          | "'self' "         |
| CSP_CONNECT    |                                                          | "'self' "         |
| CSP_FONT       |                                                          | "'self' fonts.googleapis.com" |
| CSP_OBJECT     |                                                          | "'self' "         |
| CSP_MEDIA      |                                                          | "'self' "         |
| HTTPS          |whether or not should cerbot initialize SSL certs + HTTPS | True              |

## Usage

### Standalone

### docker-compose

Here is an example of with the deployment of a wordpress app with docker-compose. Since wordpress relies on **inline-scripts**, we need to bypass default CSP.

```
services:
  wordpress:
    image: wordpress:php7.1
    expose:
      - 80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb

  db:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: exampledb
      MYSQL_USER: exampleuser
      MYSQL_PASSWORD: examplepass
      MYSQL_RANDOM_ROOT_PASSWORD: '1'

  nginx: 
    image: zar3bski/nginx_cerberus
    ports: 
      - 80:80
      - 443:443
    environment:
      DOMAIN_NAME: my.domain.com
      ADMIN_EMAIL: my@adress.com
      LOGIN_URL: /wp-login.php
      TO_CONTAINER: wordpress:80
      CSP_STYLE: "'self' 'unsafe-inline'"
      CSP_SCRIPT: "'self' 'unsafe-inline'"
```

## CURRENT ASSIGNMENT
- fix fail2ban not running
- static files
- enforce NGINX (buffer overflow prevention)
