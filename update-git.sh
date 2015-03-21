#!/bin/bash

GITDIRS="
  /home/freifunk/config/
"

for folder in ${GITDIRS}; do
  cd ${folder}
  echo "Updating `pwd`"
  git pull > /dev/null
  cd - > /dev/null
done
