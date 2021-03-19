#!/bin/bash

cd `dirname ${BASH_SOURCE:-$0}`

# This script is suitable for RHEL8

# Copy self-sign-cert CA certification to specified directory
cp -f self-sign-cert/ca.crt /etc/pki/ca-trust/source/anchors/self-sign-ca.csr
# Register self-sign-cert CA certification to host machine
update-ca-trust

# Copy bundled PEM
cp -f /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem self-sign-cert/ca-certificates.crt
# Copy Java keystore binary
cp -f /etc/pki/ca-trust/extracted/java/cacerts self-sign-cert/cacerts

# If you want to restore the state of the host machine
# please run "unregisterselfsigncert.sh"
