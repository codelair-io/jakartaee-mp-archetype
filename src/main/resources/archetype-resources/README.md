# Jakarta EE & MP Project Archetype
A starter archetype for a ThinWar project using Jakarta EE and MicroProfile, without any sketchy parent-pom's. 

| Dependency           | Version |
|----------------------|---------|
| Java EE / Jakarta EE | 8       |
| MicroProfile         | 3.0     |

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
