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

FROM openshift3/selenium-node-base:latest
ARG SELENIUM_VERSION="3.141.59"
ARG GRID_DEBUG="false"

LABEL maintainer="deven.phillips@redhat.com" \
      description="Selenium node with Google Chrome based on Red Hat Enterprise Linux"

USER root

RUN curl -L -s -o /tmp/chrome.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && yum install -y /tmp/chrome.rpm && rm -f /tmp/chrome.rpm

ARG CHROME_DRIVER_VERSION="latest"
RUN CD_VERSION=$(if [ ${CHROME_DRIVER_VERSION:-latest} = "latest" ]; then echo $(curl -L -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE); else echo $CHROME_DRIVER_VERSION; fi) \
  && echo "Using chromedriver version: "$CD_VERSION \
  && curl -L -s -o /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CD_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CD_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CD_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CD_VERSION /usr/bin/chromedriver

#=================================
# Chrome Launch Script Wrapper
#=================================
COPY wrap_chrome_binary /opt/bin/wrap_chrome_binary
RUN chmod 755 /opt/bin/wrap_chrome_binary
RUN /opt/bin/wrap_chrome_binary

COPY generate_config /opt/bin/generate_config
RUN chmod 755 /opt/bin/generate_config

USER 1001