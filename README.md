# Jakarta EE 8 & MicroProfile Starter Archetype
A starter archetype for a ThinWar project using Jakarta EE and MicroProfile, without any sketchy parent-pom's.

## Project structure
├── mvnw
├── mvnw.cmd
├── pom.xml
├── src
│   └── main
│       ├── java
│       │   └── a
│       │       └── b
│       │           └── c
│       │               ├── JaxRSConfiguration.java
│       │               └── ping
│       │                   ├── boundary
│       │                   │   └── PingResource.java
│       │                   └── model
│       │                       └── Greeting.java
│       ├── resources
│       │   └── META-INF
│       │       └── microprofile-config.properties
│       └── webapp
│           └── WEB-INF
│               └── beans.xml
├── wad.jar
└── wad.sh
