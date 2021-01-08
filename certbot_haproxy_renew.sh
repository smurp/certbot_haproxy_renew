#!/bin/sh

# Purpose:
#    Create SSL certs for haproxy from output of 'certbot renew'
# Repo:
#    https://github.com/smurp/certbot_haproxy_renew

/usr/bin/certbot -q renew

LEA=/etc/letsencrypt/archive   # where the new files really live
LEL=/etc/letsencrypt/live      # the domains which are LIVE
HAC=/etc/haproxy/certs         # where the certs will go

make_cert() {
    DOM="$1"
    FULLCHAIN=`ls -t $LEA/$DOM/fullchain*.pem | head -1`
    PRIVKEY=`ls -t $LEA/$DOM/privkey*.pem | head -1`
    CERT="$HAC/${DOM}.pem"
    # only (re)write the CERT if does not exist OR is old
    if [ ! -f "$CERT" ] || [ "$FULLCHAIN" -nt "$CERT" ] ; then
        #echo "make_cert $CERT"
        cat "$FULLCHAIN" "$PRIVKEY" > "$CERT"
    #else
        #echo "make_cert skipping $CERT Newer than $FULLCHAIN"
    fi
}

for DOMAIN in `ls -d ${LEL}/*`
do
    make_cert `basename "$DOMAIN"`
done

systemctl restart haproxy
