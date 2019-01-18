#!/bin/bash

set -e

oc status

for I in selenium-base selenium-hub selenium-node-base selenium-node-chrome selenium-node-chrome-debug selenium-node-firefox selenium-node-firefox-debug
do
  if [[ "${I}" == "selenium-base" ]]; then
    oc process -f openshift-templates/docker-build-with-namespace.yaml --param-file params/${I} | oc apply -f -
  else
    oc process -f openshift-templates/docker-build-without-namespace.yaml --param-file params/${I} | oc apply -f -
  fi
done