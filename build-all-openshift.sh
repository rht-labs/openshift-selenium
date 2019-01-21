#!/bin/bash

# Copyright 2019 Red Hat, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

NAMESPACE=$(oc project | awk -F'"' '{print $2}')

read -p "Preparing to deploy Selenium Grid to namespace '${NAMESPACE}'. Is that OK (y/N)? " confirmation
IS_CONFIRMED=$( echo ${confirmation:-n} | tr A-Z a-z )

if [[ "${IS_CONFIRMED}X" == "yX" ]]; then

  for I in selenium-base selenium-hub selenium-node-base selenium-node-chrome selenium-node-chrome-debug selenium-node-firefox selenium-node-firefox-debug
  do
    if [[ "${I}" == "selenium-base" ]]; then
      oc process -f openshift-templates/docker-build-with-namespace.yaml --param-file params/${I} | oc apply -f -
    else
      oc process -f openshift-templates/docker-build-without-namespace.yaml --param-file params/${I} | oc apply -f -
    fi
  done

  oc process -f openshift-templates/selenium-deployment.yaml --param="SELENIUM_NAMESPACE=${NAMESPACE}" -o yaml | oc apply -f -
else
  echo "Aborting"
fi