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

FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift:latest
ARG SELENIUM_VERSION="3.141.59"

LABEL maintainer="deven.phillips@redhat.com" \
      description="Base container image for Selenium based on Red Hat Enterprise Linux"

USER root

RUN chmod 666 /etc/passwd && chown root:root /etc/passwd

#==========
# Selenium
#==========
RUN mkdir -p /opt/selenium/lib
RUN chown root:root /opt/selenium && chmod 1775 /opt/selenium
WORKDIR /opt/selenium/lib
RUN curl -L -o /opt/selenium/lib/selenium-server-standalone.jar https://selenium-release.storage.googleapis.com/$(echo ${SELENIUM_VERSION} | awk -F"." '{print $1"."$2}')/selenium-server-standalone-${SELENIUM_VERSION}.jar
RUN chown root:root /opt/selenium
RUN chmod 1775 /opt/selenium

USER 1001