#!/bin/bash -e

# Runs a development environment on a local docker-engine or any OCI compliant engine
# Also attaches volume mounts to ./payara and ./target folder.
SERVER_VERSION=5.193
JDK_VERSION=jdk$(cat pom.xml | grep 'java.version>' | cut -d '<' -f 2 | cut -d '>' -f 2)
WAR_NAME=$(cat pom.xml | grep 'artifactId>' -m1 | cut -d '<' -f 2 | cut -d '>' -f 2)
CONTAINER_NAME=development-payara-micro-${JDK_VERSION}

echo "Server version: ${SERVER_VERSION}"
echo "JDK version (extracted from pom.xml): ${JDK_VERSION}"
echo "WAR name (extracted from pom.xml): ${WAR_NAME}"

echo "--> Pre-building application using maven"
./mvnw clean install

echo "--> Running payara dev-environment v${SERVER_VERSION} using ${JDK_VERSION} on docker"
# TODO: Use payara full with WebProfile to get hot-reload
#docker run -d --rm \
#    -p 8080:8080 -p 8181:8181 \
#    -v "$(pwd)"/payara/asadmin-preboot:/tmp/src/payara/asadmin-preboot \
#    -v "$(pwd)"/payara/asadmin-postboot:/tmp/src/payara/asadmin-postboot \
#    -v "$(pwd)"/payara/asadmin-postdeploy:/tmp/src/payara/asadmin-postdeploy \
#    -v "$(pwd)"/payara/lib/:/opt/lib/ \
#    -v /tmp/wad-dropins/:/opt/deploy/ \
#    --name ${CONTAINER_NAME} \
#    payara-micro-jdk11:latest

echo "--> Starting WAD (Watch and Deploy)..."
java -jar wad.jar /tmp/wad-dropins/
