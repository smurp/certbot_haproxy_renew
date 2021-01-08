#!/bin/sh

# Purpose:
#    Create SSL certs for haproxy from output of 'certbot renew'


LEA=/etc/letsencrypt/archive   # where the new files really live
LEL=/etc/letsencrypt/live      # the domains which are LIVE
HAC=/etc/haproxy/certs         # where the certs will go

make_cert() {
    DOM="$1"
    FULLCHAIN=`ls -t $LEA/$DOM/fullchain*.pem | head -1`
    PRIVKEY=`ls -t $LEA/$DOM/privkey*.pem | head -1`
    CERT=$HAC/${DOM}.pem
    echo "make_cert $CERT"
    cat $FULLCHAIN $PRIVKEY > $CERT
}

for DOMAIN in `ls -d ${LEL}/*`
do
    make_cert `basename "$DOMAIN"`
done

systemctl restart haproxy
