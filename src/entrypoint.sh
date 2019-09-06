#!/bin/sh

# FAIL TO BAN 
touch /etc/fail2ban/filter.d/auth-app.conf

escaped_login_url=${LOGIN_URL/./\\.}
escaped_login_url=${escaped_login_url/\//\\/}

printf '%s\n' \
   "[INCLUDES]" \
   "before = common.conf" \
   "[Definition]" \
   "failregex =.*POST (${escaped_login_url}/|${escaped_login_url}).*" \
>> /etc/fail2ban/filter.d/auth-app.conf

cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
printf '%s\n' \
   "[nginx-http-auth]" \
   "enabled  = true" \
   "port     = http,https" \
   "filter   = nginx-http-auth" \
   "logpath  = /var/log/nginx/error.log" \
   "maxretry = 6" \
   " " \
   "[nginx-noscript]" \
   " " \
   "enabled  = true" \
   "port     = http,https" \
   "filter   = nginx-noscript" \
   "logpath  = /var/log/nginx/access.log" \
   "maxretry = 6" \
   " " \
   "[nginx-badbots]" \
   " " \
   "enabled  = true" \
   "port     = http,https" \
   "filter   = nginx-badbots" \
   "logpath  = /var/log/nginx/access.log" \
   "maxretry = 2" \
   " " \
   "[nginx-nohome]" \
   "enabled  = true" \
   "port     = http,https" \
   "filter   = nginx-nohome" \
   "logpath  = /var/log/nginx/access.log" \
   "maxretry = 2" \
   " " \
   "[nginx-noproxy]" \
   "enabled  = true" \
   "port     = http,https" \
   "filter   = nginx-noproxy" \
   "logpath  = /var/log/nginx/access.log" \
   "maxretry = 2" \
   " " \
   "[app-authentification]" \
   "enabled  = true" \
   "findtime = 600" \
   "bantime  = 86400" \
   "port     = http,https" \
   "filter   = auth-app" \
   "logpath  = /var/log/nginx/access.log" \
   "maxretry = 3" \
>> /etc/fail2ban/jail.local

# EDIT nginx.conf
export DOMAIN_NAME
export TO_CONTAINER
envsubst '${DOMAIN_NAME},${TO_CONTAINER}' < /etc/nginx/conf.template > /etc/nginx/conf.d/nginx.conf

# CSP 

#exec "$@"
/bin/sh -c "exec nginx -g 'daemon off;'"
