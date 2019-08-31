# Jakarta EE & MP Project Archetype
A starter archetype for a ThinWar project using Jakarta EE and MicroProfile, without any sketchy parent-pom's. 

| Dependency           | Version |
|----------------------|---------|
| Java EE / Jakarta EE | 8       |
| MicroProfile         | 3.0     |

The archetype is built to be highly configurable, however we are somewhat opinionated:  
- Maven Build tool is used with an included maven wrapper
- wad (Watch and Deploy) by Adam Bien is included
- ThinWar deployment strategy is enforced
- A certain selection of Java EE / Servlet Containers have native support. (see below for more info.)

# Usage
A Thin-WAR packaged application often contains only the application source code and its internal dependencies, and is often deployed on a standalone Java EE / Servlet Container. The Archetype provides configuration files for a variety of different Java EE Containers, and can be used in cloud-native container runtime environment (e.g. OpenShift / Kubernetes) by using one of the accompanied s2i-images.

| Application Server | Config Folder Name | S2I Image                                    |   Availability   |
|--------------------|--------------------|----------------------------------------------|:----------------:|
| IBM OpenLiberty    | ./liberty/         | [hassenasse/s2i-openliberty:[latest/19.0.0.8]](https://hub.docker.com/r/hassenasse/s2i-openliberty) |     Available    |
| Payara Micro       | ./payara/          | hassenasse/s2i-payara:[..]                   | Work In Progress |
| Apache TomEE       | ./tomee/           | hassenasse/s2i-tomee:[..]                    | Work In Progress |
| KumuluzEE          | ./kumuluz/         | hassenasse/s2i-kumuluzee:[..]                | Work In Progress |

Choose the application server needed for your particular project, and discard the rest of the config-folders.

## IBM OpenLiberty
> IMPORTANT: The archetype merely pulls in a workable starting point. All configuration files in the respective server-folders should be reviewed and tuned before deploy.

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

## Apache TomEE
> IMPORTANT: The archetype merely pulls in a workable starting point. All configuration files in the respective server-folders should be reviewed and tuned before deploy.

## KumuluzEE
> IMPORTANT: The archetype merely pulls in a workable starting point. All configuration files in the respective server-folders should be reviewed and tuned before deploy.
