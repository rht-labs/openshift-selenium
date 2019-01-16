#!/bin/bash

set -e

oc status

for I in selenium-base selenium-hub selenium-node-base selenium-node-chrome selenium-node-chrome-debug selenium-node-firefox selenium-node-firefox-debug
do
  oc process --local -f openshift-templates/selenium-builds.yaml --param-file=params/${I} | oc apply -f -
done