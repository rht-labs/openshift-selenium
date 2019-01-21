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

FROM openshift3/selenium-base
ARG SELENIUM_VERSION="3.141.59"

LABEL maintainer="deven.phillips@redhat.com" \
      description="Selenium Hub based on Red Hat Enterprise Linux"

EXPOSE 4444

USER root

# As integer, maps to "maxSession"
ENV GRID_MAX_SESSION 5
# In milliseconds, maps to "newSessionWaitTimeout"
ENV GRID_NEW_SESSION_WAIT_TIMEOUT -1
# As a boolean, maps to "throwOnCapabilityNotPresent"
ENV GRID_THROW_ON_CAPABILITY_NOT_PRESENT true
# As an integer
ENV GRID_JETTY_MAX_THREADS -1
# In milliseconds, maps to "cleanUpCycle"
ENV GRID_CLEAN_UP_CYCLE 5000
# In seconds, maps to "browserTimeout"
ENV GRID_BROWSER_TIMEOUT 0
# In seconds, maps to "timeout"
ENV GRID_TIMEOUT 1800
# Debug
ENV GRID_DEBUG false
# As integer, maps to "port"
ENV GRID_HUB_PORT 4444
# As string, maps to "host"
ENV GRID_HUB_HOST "0.0.0.0"
 
COPY generate_config \
    start-selenium-hub.sh \
    /opt/bin/
RUN chmod 755 /opt/bin/start-selenium-hub.sh /opt/bin/generate_config

USER 1001

ENTRYPOINT ["/opt/bin/start-selenium-hub.sh"]