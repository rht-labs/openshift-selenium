FROM openshift3/selenium-node-base:latest
ARG SELENIUM_VERSION="3.141.59"
ARG GRID_DEBUG="false"

LABEL maintainer="deven.phillips@redhat.com" \
      description="Selenium node with Mozilla Firefox based on Red Hat Enterprise Linux"

USER root

RUN yum install -y firefox
COPY generate_config /opt/bin/generate_config
RUN chmod 755 /opt/bin/generate_config

#============
# GeckoDriver
#============
ARG GECKODRIVER_VERSION=latest
RUN GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo "0.23.0"; else echo $GECKODRIVER_VERSION; fi) \
  && echo "Using GeckoDriver version: "$GK_VERSION \
  && curl -L -s -o /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GK_VERSION \
  && chmod 755 /opt/geckodriver-$GK_VERSION \
  && ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver

#==========
# Relaxing permissions for OpenShift and other non-sudo environments
#==========
RUN chmod -R 777 ${HOME} \
  && chgrp -R 0 ${HOME} \
  && chmod -R g=u ${HOME}

USER 1001