#!/bin/bash

cd `dirname ${BASH_SOURCE:-$0}`

docker-compose -f ./docker-compose.yml -f ./docker-compose-inits.yml run --rm taiga-manage createsuperuser
