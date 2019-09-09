# Nginx Cerberus Proxy
A custom Nginx proxy pass image for the typical web application. Covers most simple needs 

## Features

* fail2ban: creation of a filter based on the `LOGIN_URL` env provided
* static files serving
* HTTPS with certbot
* [Content Security Policy](https://developer.mozilla.org/fr/docs/Web/HTTP/CSP). The execution of inline scripts is disabled by default but could be allowed by overriding CSP environnement variables (see below)

## Env variables

Any of these variables could be overrided to change the container's behavior

| variable name  | description                                              | default value     |
|---------------:|:---------------------------------------------------------|:-----------------:|
| DOMAIN_NAME    | domain name of your application                          | my.domain.com     |
| LOGIN_URL      | login url of the application (fail2ban)                  | |/admin
| STATICFILES_URL| root url of static files that Nginx should serve         | /some/url/to/check
| TO_CONTAINER   | container: port that Nginx should pass the connection to | some_container:80
| CSP_DEFAULT    |                                                          | "'self' "
| CSP_SCRIPT     |                                                          | "'self' "
| CSP_STYLE      |                                                          | "'self' "
| CSP_IMG        |                                                          | "'self' "
| CSP_CONNECT    |                                                          | "'self' "
| CSP_FONT       |                                                          | "'self' fonts.googleapis.com"
| CSP_OBJECT     |                                                          | "'self' "
| CSP_MEDIA      |                                                          | "'self' "
| HTTPS          |whether or not should cerbot initialize SSL certs + HTTPS | True

## Usage

### Standalone

### Docker-compose


## CURRENT ASSIGNMENT
- fix fail2ban not running
- static files
- enforce NGINX (buffer overflow prevention)
