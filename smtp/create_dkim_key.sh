#!/bin/sh

cd `dirname ${BASH_SOURCE:-$0}`

opendkim-genkey -b 2048 -d <DOMAIN> -D $(pwd)/mount -s mail -v
