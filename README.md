# certbot_haproxy_renew

Turn renewal of all your certbot certs for haproxy into a single command suitable for crontab

## Assumptions

You are:
* using HAProxy
* using CertBot, ie LetsEncrypt
* loading SSL certificates like `bind *:433 ssl crt /etc/haproxy/certs` in /etc/haproxy/haproxy.conf
* running one or more sites with SSL
* renewing your certs at once like `cerbbot renew`
* extraordinarily lazy :-)

## What it does

* runs `certbot -q renew` to have certbot update any certificates which need it
* deploys any newly generated certificates in the combined format needed by HAProxy

## How to obtain

```
cd /opt
wget https://raw.githubusercontent.com/smurp/certbot_haproxy_renew/main/certbot_haproxy_renew.sh
```

## How to automate

Add a line to root's crontab which looks like this:
```
0 */12 * * * /opt/certbot_haproxy_renew.sh
```
