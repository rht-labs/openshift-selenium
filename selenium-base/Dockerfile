FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift:latest
ARG SELENIUM_VERSION="3.141.59"

LABEL maintainer="deven.phillips@redhat.com" \
      description="Base container image for Selenium based on Red Hat Enterprise Linux"

USER root

RUN chown 666 /etc/passwd

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