#!/usr/bin/env bash

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