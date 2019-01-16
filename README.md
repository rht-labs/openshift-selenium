# Selenium Images and Templates for OpenShift Container Platform based on Red Hat Enterprise Linux

To ensure that the containers and configurations are able to be supported by Red Hat, 
these Dockerfiles and templates use RHEL as the base container image. The work on this
project borrows heavily from the [SeleniumHQ Docker Repository](https://github.com/SeleniumHQ/docker-selenium/).

## Build Containers Locally
```bash
git clone https://github.com/rht-labs/openshift-selenium.git
cd openshift-selenium
./build-all.sh
```

## Build On OpenShift
```bash
oc login -u <username> <openshift_console_url>
oc new-project selenium-grid
oc process -f openshift-templates/container_builds.yml | oc apply -f -
```

## Deploy On OpenShift
```bash
oc login -u <username> <openshift_console_url>
oc new-project selenium-grid
oc process -f openshift-templates/deployment.yml | oc apply -f -
```
