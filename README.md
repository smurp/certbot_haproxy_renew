# certbot_haproxy_renew
Update HAProxy after `certbot renew`

## Assumptions

You are:
* using HAProxy
* using CertBot
* loading SSL certificates like `bind *:433 ssl crt /etc/haproxy/certs`
* renewing your certs like `cerbbot renew`
* extraordinarily lazy :-)

## How to obtain

```wget https://raw.githubusercontent.com/smurp/certbot_haproxy_renew/main/certbot_haproxy_renew.sh```

## How to automate

Make a crontask so it runs sometime after `certbot renew`
