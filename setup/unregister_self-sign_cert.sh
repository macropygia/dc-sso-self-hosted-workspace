#!/bin/bash

cd `dirname ${BASH_SOURCE:-$0}`

# This script is suitable for RHEL8

unlink /etc/pki/ca-trust/source/anchors/self-sign-ca.csr
update-ca-trust
