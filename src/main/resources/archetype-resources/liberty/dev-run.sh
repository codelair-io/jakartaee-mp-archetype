#!/bin/bash -e

# Runs a development environment on a local docker-engine or any OCI compliant engine
# Also attaches volume mounts to ./liberty and ./target folder.
SERVER_VERSION=19.0.0.8
JDK_VERSION=jdk$(cat pom.xml | grep 'java.version>' | cut -d '<' -f 2 | cut -d '>' -f 2)
WAR_NAME=$(cat pom.xml | grep 'artifactId>' -m1 | cut -d '<' -f 2 | cut -d '>' -f 2)
CONTAINER_NAME=development-openliberty-${JDK_VERSION}

echo "Server version: ${SERVER_VERSION}"
echo "JDK version (extracted from pom.xml): ${JDK_VERSION}"
echo "WAR name (extracted from pom.xml): ${WAR_NAME}"

echo "--> Pre-building application using maven"
./mvnw clean install

echo "--> Running openliberty dev-environment v${SERVER_VERSION} using ${JDK_VERSION} on docker"
docker run -d --rm \
    -p 9080:9080 -p 9443:9443 \
    -v "$(pwd)"/liberty/server.xml:/opt/liberty/wlp/usr/servers/defaultServer/server.xml \
    -v "$(pwd)"/liberty/server.env:/opt/liberty/wlp/usr/servers/defaultServer/server.env \
    -v "$(pwd)"/liberty/jvm.options:/opt/liberty/wlp/usr/servers/defaultServer/jvm.options \
    -v "$(pwd)"/liberty/bootstrap.properties:/opt/liberty/wlp/usr/servers/defaultServer/bootstrap.properties \
    -v "$(pwd)"/liberty/resources:/opt/liberty/wlp/usr/shared/resources/ \
    -v /tmp/wad-dropins/:/opt/liberty/wlp/usr/servers/defaultServer/dropins/ \
    --name ${CONTAINER_NAME} \
    hassenasse/openliberty:${SERVER_VERSION}-${JDK_VERSION}

echo "--> Starting WAD (Watch and Deploy)..."
java -jar wad.jar /tmp/wad-dropins/
