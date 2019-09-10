#!/bin/bash -e

# Runs a development environment on a local docker-engine or any OCI compliant engine
# Also attaches volume mounts to ./liberty and ./target folder.
SERVER_VERSION=5.193
JDK_VERSION=jdk$(cat pom.xml | grep 'java.version>' | cut -d '<' -f 2 | cut -d '>' -f 2)
WAR_NAME=$(cat pom.xml | grep 'artifactId>' -m1 | cut -d '<' -f 2 | cut -d '>' -f 2)
CONTAINER_NAME=development-payara-full-${JDK_VERSION}

echo "Server version: ${SERVER_VERSION}"
echo "JDK version (extracted from pom.xml): ${JDK_VERSION}"
echo "WAR name (extracted from pom.xml): ${WAR_NAME}"

echo "--> Pre-building application using maven"
./mvnw clean install

echo "--> Running payara dev-environment v${SERVER_VERSION} using ${JDK_VERSION} on docker"
docker run -d --rm \
    -p 8080:8080 -p 8181:8181 -p 4848:4848 -p 9009:9009 \
    -v "$(pwd)"/payara/lib/:/opt/payara/appserver/glassfish/domains/production/lib/ \
    -v /tmp/wad-dropins/:/opt/payara/appserver/glassfish/domains/production/autodeploy/ \
    -v "$(pwd)"/payara/asadmin-postboot:/opt/payara/config/post-boot-commands.asadmin \
    -v "$(pwd)"/payara/asadmin-preboot:/opt/payara/config/pre-boot-commands.asadmin \
    --name ${CONTAINER_NAME} \
    hassenasse/payara:${SERVER_VERSION}-${JDK_VERSION}


echo "--> Starting WAD (Watch and Deploy)..."
java -jar wad.jar /tmp/wad-dropins/
