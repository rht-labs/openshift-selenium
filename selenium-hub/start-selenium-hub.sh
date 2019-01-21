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

# set -e: exit asap if a command exits with a non-zero status
set -e

ROOT=/opt/selenium
CONF=${ROOT}/config.json

USER_ID=$(id -u)
GROUP_ID=$(id -g)

printf "ocpuser:x:%s:%s:OpenShift User:/home/ocpuser:/bin/bash\n" ${USER_ID} ${GROUP_ID} >> /etc/passwd

/opt/bin/generate_config >${CONF}

echo "Starting Selenium Hub with configuration:"
cat ${CONF}

if [ ! -z "$SE_OPTS" ]; then
  echo "Appending Selenium options: ${SE_OPTS}"
fi

java ${JAVA_OPTS} -jar /opt/selenium/lib/selenium-server-standalone.jar \
  -role hub \
  -hubConfig ${CONF} \
  ${SE_OPTS}