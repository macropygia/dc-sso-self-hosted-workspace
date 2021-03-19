#!/bin/bash

cd `dirname ${BASH_SOURCE:-$0}`

openssl x509 -sha1 -fingerprint -noout -in keycloak_relm.crt
