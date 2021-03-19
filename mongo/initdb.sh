#!/bin/bash

cd `dirname ${BASH_SOURCE:-$0}`

echo When the console stops and displays \"Waiting for connections\", press Ctrl+C once.

docker-compose -f docker-compose_setup.yml up

sleep 1

while :
do
  if [ $(docker inspect -f "{{.State.Running}}" "mongoinit") = "false" ]; then
    break;
  fi
  sleep 1
done

sleep 1

docker-compose -f docker-compose_setup.yml down

echo Finish.
