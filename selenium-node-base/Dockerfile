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
      description="Base node image for Selenium based on Red Hat Enterprise Linux"

USER root

RUN yum install --enablerepo=rhel-7-server-optional-rpms -y xorg-x11-server-Xvfb fontconfig-devel fontconfig freetype-devel freetype \
    liberation-fonts-common liberation-mono-fonts liberation-narrow-fonts liberation-sans-fonts liberation-serif-fonts \
    xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-fonts-ISO8859-1-100dpi xorg-x11-fonts-ISO8859-1-75dpi xorg-x11-fonts-ISO8859-14-100dpi \
    xorg-x11-fonts-ISO8859-14-75dpi xorg-x11-fonts-ISO8859-15-75dpi xorg-x11-fonts-ISO8859-2-100dpi xorg-x11-fonts-ISO8859-2-75dpi \
    xorg-x11-fonts-ISO8859-9-100dpi xorg-x11-fonts-ISO8859-9-75dpi xorg-x11-fonts-Type1 xorg-x11-fonts-cyrillic xorg-x11-fonts-ethiopic \
    xorg-x11-fonts-misc liberation-fonts

COPY start-selenium-node.sh /opt/bin/
RUN chmod 755 /opt/bin/start-selenium-node.sh

# Set Xvfb screen dimensions and environment
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

#========================
# Selenium Configuration
#========================
# As integer, maps to "maxInstances"
ENV NODE_MAX_INSTANCES 1
# As integer, maps to "maxSession"
ENV NODE_MAX_SESSION 1
# As integer, maps to "port"
ENV NODE_PORT 5555
# In milliseconds, maps to "registerCycle"
ENV NODE_REGISTER_CYCLE 5000
# In milliseconds, maps to "nodePolling"
ENV NODE_POLLING 5000
# In milliseconds, maps to "unregisterIfStillDownAfter"
ENV NODE_UNREGISTER_IF_STILL_DOWN_AFTER 60000
# As integer, maps to "downPollingLimit"
ENV NODE_DOWN_POLLING_LIMIT 2
# As string, maps to "applicationName"
ENV NODE_APPLICATION_NAME ""

ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

USER 1001

EXPOSE 5555

ENTRYPOINT ["/opt/bin/start-selenium-node.sh"]