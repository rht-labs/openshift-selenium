FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift
ARG SELENIUM_VERSION="3.141.59"

LABEL maintainer "deven.phillips@redhat.com" \
      description "Base container image for Selenium based on Red Hat Enterprise Linux"

USER root

RUN chown 666 /etc/passwd

#==========
# Selenium
#==========
RUN mkdir -p /opt/selenium/lib && yum install -y wget
WORKDIR /opt/selenium/lib
RUN wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-java/${SELENIUM_VERSION}/selenium-java-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-chrome-driver/${SELENIUM_VERSION}/selenium-chrome-driver-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-remote-driver/${SELENIUM_VERSION}/selenium-remote-driver-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-server/${SELENIUM_VERSION}/selenium-server-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-api/${SELENIUM_VERSION}/selenium-api-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-edge-driver/${SELENIUM_VERSION}/selenium-edge-driver-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-firefox-driver/${SELENIUM_VERSION}/selenium-firefox-driver-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-ie-driver/${SELENIUM_VERSION}/selenium-ie-driver-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-opera-driver/${SELENIUM_VERSION}/selenium-opera-driver-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-safari-driver/${SELENIUM_VERSION}/selenium-safari-driver-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-support/${SELENIUM_VERSION}/selenium-support-3.141.59.jar && \
    wget https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/jetty-repacked/9.4.12.v20180830/jetty-repacked-9.4.12.v20180830.jar
USER 1001