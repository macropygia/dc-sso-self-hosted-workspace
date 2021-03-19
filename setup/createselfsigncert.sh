#!/bin/bash

cd `dirname ${BASH_SOURCE:-$0}`

docker run --rm -v $PWD/self-sign-cert:/out -e HOST=*.<DOMAIN> -e IP=<LOCAL_IP> tkuni83/self-sign-cert
cp -f self-sign-cert/server.key ../proxy/mount/certs/self-sign.key
cp -f self-sign-cert/server.crt ../proxy/mount/certs/self-sign.crt
