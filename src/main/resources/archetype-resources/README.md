# Jakarta EE & MicroProfile Project Archetype

A starter archetype for a ThinWar project using Jakarta EE and MicroProfile, without any sketchy parent-pom's.

| Dependency           | Version |
| -------------------- | ------- |
| Java EE / Jakarta EE | 8       |
| MicroProfile         | 3.0     |

The archetype is built to be highly configurable, however we are somewhat opinionated:

- Maven Build tool is used with an included maven wrapper
- wad (Watch and Deploy) by Adam Bien is included for easier development, see www.wad.sh
- ThinWar deployment strategy is enforced
- A certain selection of Java EE / Servlet Containers have native support using s2i images. (see below for more info.)

## Overview of included components
| Folder path                 | Description                                                                                                                                                             |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ./liberty  | OpenLiberty Server configuration folder, usable with [hassenasse/s2i-openliberty:[19.0.0.8-jdk8/jdk11]](https://hub.docker.com/r/hassenasse/s2i-openliberty) s2i image. Additionally contains a `dev-run.sh` which starts a development environment image of OpenLiberty and [WAD](www.wad.sh). |
| ./payara  | Payara Micro Server configuration folder, usable with [hassenasse/s2i-payara-micro:[5.193-jdk8/jdk11]](https://hub.docker.com/r/hassenasse/s2i-payara-micro) s2i image. Additionally contains a `dev-run.sh` which starts a development environment image of Payara Full and [WAD](www.wad.sh). |
| ./kumuluz  | KumuluzEE Server configuration folder, (to be added) |
| ./tomee  | Apache TomEE Server configuration folder, (to be added) |
| ./metrics | Folder containing                                                                                                  |
| ./ci | Shell-script for initiating a prometheus and grafana docker-containers.                                                                                                 |

# Metrics using Prometheus & Grafana
A folder with name `./metrics` is provided with the following files:  

| File path                 | Description                                                                                                                                                             |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ./metrics/prometheus.yml  | YAML formatted type which is injected into the prometheus runtime for configuration. This file defines various scraping targets for prometheus and scrape interval etc. |
| ./metrics/metrics-init.sh | Shell-script for initiating a prometheus and grafana docker-containers.                                                                                                 |
  
## Gathering and visualizing
1. Start the application server with your application deployment
2. Start prometheus and grafana using `cd metrics && ./metrics-init.sh`
3. Navigate to `http://localhost:9090/targets` and inspect that the `status` for your particular application server is up
and scraping metrics.
4. Navigate to `http://localhost:3000` and configure a `browser` based prometheus datasource which points to `http://localhost:9090`. Choose `save and test`.
5. You can now create your dashboards using the Prometheus/OpenMetrics-QL.

# Usage with S2I images

A Thin-WAR packaged application often contains only the application source code and its internal dependencies, and is often deployed on a standalone Java EE / Servlet Container. The Archetype provides configuration files for a variety of different Java EE Containers, and can be used in cloud-native container runtime environment (e.g. OpenShift / Kubernetes) by using one of the accompanied s2i-images.

| Application Server | Config Folder Name | S2I Image                                                                                               |   Availability   |
| ------------------ | ------------------ | ------------------------------------------------------------------------------------------------------- | :--------------: |
| IBM OpenLiberty    | ./liberty/         | [hassenasse/s2i-openliberty:[19.0.0.8-jdk8/jdk11]](https://hub.docker.com/r/hassenasse/s2i-openliberty) |    Available     |
| Payara Micro       | ./payara/          | [hassenasse/s2i-payara-micro:[5.193-jdk8/jdk11]](https://hub.docker.com/r/hassenasse/s2i-payara-micro)  |    Available     |
| KumuluzEE          | ./kumuluz/         | hassenasse/s2i-kumuluzee:[..]                                                                           | Work In Progress |
| Apache TomEE       | ./tomee/           | hassenasse/s2i-tomee:[..]                                                                               | Work In Progress |

Choose the application server needed for your particular project, and discard the rest of the config-folders. Based on the selection of application server vendor, the MicroProfile dependency version in the `pom.xml` might require tweaking. Per default the archetype ships with `MicroProfile 3.0`. Read the corresponding server documentation and s2i doc for more information about the supporting MP version.

## IBM OpenLiberty

> IMPORTANT: The archetype merely pulls in a workable starting point. All configuration files in the respective server-folders should be reviewed and tuned before deploy.

### Development

A `dev-run.sh` script is provided under `./liberty` folder to allow running a local development environment on a docker container. The shell script provisions an openliberty container on a running engine, and starts `wad (Watch and Deploy)` with docker volume mounts to automatically traverse changes to the container when developing. In addition, volume mounts are added to the following files in `./liberty`

- server.xml
- server.env
- jvm.properties
- bootstrap.properties

1. Start the dev-environment using `./liberty/dev-run.sh`  
   Whilst developing, `wad` will watch for file changes in `src`, run a `mvn clean install` to a artifact directory which the docker image is mounted to.
2. Inspect the image using `docker container ls`
3. Inspect logs using `docker logs development-openliberty-jdk<11/1.8> -f`

### S2I Deployment

Below is en excerpt from https://hub.docker.com/r/hassenasse/s2i-openliberty, which details each file in `./liberty` and their purpose.

| File/Folder Name     |                                                                                                                                                        Description                                                                                                                                                        |
| -------------------- | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| server.xml           |                                                                                                      The application server configuration is described in a series of elements in the server.xml configuration file.                                                                                                      |
| server.env           |                                                                                                 The Liberty specific environment variables can be configured in the server.env file to customize the Liberty environment.                                                                                                 |
| jvm.options          |                                                                          The jvm.options files are optional but, when present, are read by the bin/server shell script to determine what options to use when launching the JVM for Open Liberty.                                                                          |
| bootstrap.properties | The bootstrap.properties file is optional but, when present, it is read during Open Liberty bootstrap to provide config for the earliest stages of the server start-up. It is read by the server much earlier than server.xml so it can affect the start-up and behavior of the Open Liberty kernel right from the start. |
| resources/           |                                                                       Shared resource definitions: adapters, data sources, are injected into `wlp/usr/shared/resources/`. Can be referenced in server.xml using `${shared.resource.dir}` property.                                                                        |

## Payara Micro

> IMPORTANT: The archetype merely pulls in a workable starting point. All configuration files in the respective server-folders should be reviewed and tuned before deploy.

### Development
Development with auto-deploy for payara-micro is currently not supported, thus, we use a payara-full image for development purposes.  
A `dev-run.sh` script is provided under `./payara` folder to allow running a local development environment on a docker container. The shell script provisions an openliberty container on a running engine, and starts `wad (Watch and Deploy)` with docker volume mounts to automatically traverse changes to the container when developing. In addition, volume mounts are added to the following files in `./payara`

- asadmin-preboot
- asadmin-postboot
- lib/

1. Start the dev-environment using `./payara/dev-run.sh`  
   Whilst developing, `wad` will watch for file changes in `src`, run a `mvn clean install` to a artifact directory which the docker image is mounted to.
2. Inspect the image using `docker container ls`
3. Inspect logs using `docker logs development-payara-full-jdk<11/1.8> -f`


### S2I Deployment

Below is en excerpt from https://hub.docker.com/r/hassenasse/s2i-payara-micro, which details each file in ./payara and their purpose.

| File/Folder Name   |                                                                                    Description                                                                                     |
| ------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| asadmin-preboot    |                                    Provides a file of asadmin commands to run before booting the server (only some commands work at this point)                                    |
| asadmin-postboot   |                                                        Provides a file of asadmin commands to run after booting the server                                                         |
| asadmin-postdeploy |                                                  Provides a file of asadmin commands to run after all deployments have completed                                                   |
| lib/               | Allows adding various third-party libraries to the class path of a Payara Micro instance. Use cases may include required JDBC drivers, or libraries used by multiple applications. |

## KumuluzEE

> IMPORTANT: The archetype merely pulls in a workable starting point. All configuration files in the respective server-folders should be reviewed and tuned before deploy.

## Apache TomEE

> IMPORTANT: The archetype merely pulls in a workable starting point. All configuration files in the respective server-folders should be reviewed and tuned before deploy.
