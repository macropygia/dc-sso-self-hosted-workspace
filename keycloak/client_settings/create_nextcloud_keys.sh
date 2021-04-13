#!/bin/sh

cd `dirname ${BASH_SOURCE:-$0}`

openssl req -nodes -new -x509 --days 10000 -keyout nextcloud_private.key -out nextcloud_public.crt -subj "/C=XX/ST=/L=Default City/O=Default Company Ltd/OU=/CN="
