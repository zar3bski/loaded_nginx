# loaded_nginx
A custom Nginx proxy pass image for the typical web application

## Features

* fail2ban: creation of a filter based on the `LOGIN_URL` env provided
* static files serving
* HTTPS with certbot
* [Content Security Policy](https://developer.mozilla.org/fr/docs/Web/HTTP/CSP). The execution of inline script are disabled by default but could be allowed by overriding CSP environnement variables (see below)

## Env variables

## TODO
- check that fail2ban is running
- CSP
- static files


