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

USER_ID=$(id -u)
GROUP_ID=$(id -g)

printf "ocpuser:x:%s:%s:OpenShift User:/home/ocpuser:/bin/bash\n" ${USER_ID} ${GROUP_ID} >> /etc/passwd

/opt/bin/generate_config > /opt/selenium/config.json

if [ ! -e /opt/selenium/config.json ]; then
  echo No Selenium Node configuration file, the node-base image is not intended to be run directly. 1>&2
  exit 1
fi

# In the long term the idea is to remove $HUB_PORT_4444_TCP_ADDR and $HUB_PORT_4444_TCP_PORT and only work with
# $HUB_HOST and $HUB_PORT
if [ ! -z "$HUB_HOST" ]; then
  HUB_PORT_PARAM=4444
  if [ ! -z "$HUB_PORT" ]; then
      HUB_PORT_PARAM=${HUB_PORT}
  fi
  echo "Connecting to the Hub using the host ${HUB_HOST} and port ${HUB_PORT_PARAM}"
  HUB_PORT_4444_TCP_ADDR=${HUB_HOST}
  HUB_PORT_4444_TCP_PORT=${HUB_PORT_PARAM}
fi

if [ -z "$HUB_PORT_4444_TCP_ADDR" ]; then
  echo "Not linked with a running Hub container" 1>&2
  exit 1
fi

REMOTE_HOST_PARAM=""
if [ ! -z "$REMOTE_HOST" ]; then
  echo "REMOTE_HOST variable is set, appending -remoteHost"
  REMOTE_HOST_PARAM="-remoteHost $REMOTE_HOST"
fi

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

rm -f /tmp/.X*lock

export GEOMETRY=$(printf "%sx%sx%s" ${SCREEN_WIDTH} ${SCREEN_HEIGHT} ${SCREEN_DEPTH})

nohup /usr/bin/Xvfb ${DISPLAY} -screen 0 ${GEOMETRY} -ac +extension RANDR &

java ${JAVA_OPTS} -jar /opt/selenium/lib/selenium-server-standalone.jar \
  -role node \
  -hub http://$HUB_PORT_4444_TCP_ADDR:$HUB_PORT_4444_TCP_PORT/grid/register \
  ${REMOTE_HOST_PARAM} \
  -host 0.0.0.0 \
  -nodeConfig /opt/selenium/config.json \
  ${SE_OPTS}