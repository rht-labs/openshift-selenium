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

RUN /opt/bin/generate_config > /opt/selenium/config.json

USER 1001

ENTRYPOINT ["/opt/bin/start-selenium-hub.sh"]