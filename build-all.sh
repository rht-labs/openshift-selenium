#!/usr/bin/env bash

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

set -x
set -e

export SELENIUM_VERSION="3.141.59"


BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for I in selenium-base selenium-hub selenium-node-base selenium-node-chrome selenium-node-chrome-debug selenium-node-firefox selenium-node-firefox-debug
do
  cd ${BASEDIR}
  TARGET_DIR=$(echo $I | sed 's@-debug@@g')
  cd ${TARGET_DIR}
  if [[ "${I}" == *"-debug" ]]; then
    if [[ -f Dockerfile ]]; then
      ## Build Debug Container
      docker build --no-cache -t openshift3/${I}:${SELENIUM_VERSION} --build-arg GRID_DEBUG="true" --build-arg SELENIUM_VERSION="${SELENIUM_VERSION}" ./
      docker tag openshift3/${I}:${SELENIUM_VERSION} openshift3/${I}:latest
    fi
  else
    if [[ -f Dockerfile ]]; then
      ## Build regular container
      docker build --no-cache -t openshift3/${I}:${SELENIUM_VERSION} --build-arg SELENIUM_VERSION="${SELENIUM_VERSION}" ./
      docker tag openshift3/${I}:${SELENIUM_VERSION} openshift3/${I}:latest
    fi
  fi
  cd ${BASEDIR}
done