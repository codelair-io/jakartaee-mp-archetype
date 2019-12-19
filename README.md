# Jakarta EE 8 & MicroProfile Starter Archetype
A starter archetype for a ThinWar project using Jakarta EE and MicroProfile, without sketchy parent-pom's.

[Archetype Documentation](https://github.com/codelair-io/jakartaee-mp-archetype/blob/master/src/main/resources/archetype-resources/README.md)

## Project Generation (Interactive Mode)

`mvn archetype:generate -DarchetypeGroupId=net.hassannazar -DarchetypeArtifactId=jakartaee-mp-archetype -DarchetypeVersion=1.4.0  `  
By using the above snippet, maven-archetype-plugin will walk you through all necessary configuration and bootstrap the project to the current working-dir.

## Using Kotlin
Change `src/main/java` to `src/main/kotlin` and refactor your `*.java` klasses to `*.kt`. In addition, add the following segments to `<properties>`, `<dependencies>` and `<build>`.
```xml
<properties>
    <kotlin.version>1.3.61</kotlin.version>
    ...
</properties>

<dependencies>
    ...

    <!--Kotlin Dependencies-->
    <dependency>
        <groupId>org.jetbrains.kotlin</groupId>
        <artifactId>kotlin-stdlib-jdk8</artifactId>
        <version>${kotlin.version}</version>
    </dependency>
    <dependency>
        <groupId>org.jetbrains.kotlin</groupId>
        <artifactId>kotlin-test</artifactId>
        <version>${kotlin.version}</version>
        <scope>test</scope>
    </dependency>
</dependencies>

<build>
    <finalName>##SERVICE_NAME##</finalName>
    <sourceDirectory>src/main/kotlin</sourceDirectory>
    <plugins>
        <plugin>
            <groupId>org.jetbrains.kotlin</groupId>
            <artifactId>kotlin-maven-plugin</artifactId>
            <version>${kotlin.version}</version>
            <executions>
                <execution>
                    <id>compile</id>
                    <phase>compile</phase>
                    <goals>
                        <goal>compile</goal>
                    </goals>
                </execution>
                <execution>
                    <id>test-compile</id>
                    <phase>test-compile</phase>
                    <goals>
                        <goal>test-compile</goal>
                    </goals>
                </execution>
            </executions>
            <configuration>
                <compilerPlugins>
                    <plugin>all-open</plugin>
                </compilerPlugins>
                <pluginOptions>
                    <option>all-open:annotation=javax.ws.rs.Path</option>
                    <option>all-open:annotation=javax.enterprise.context.RequestScoped</option>
                    <option>all-open:annotation=javax.enterprise.context.SessionScoped</option>
                    <option>all-open:annotation=javax.enterprise.context.ApplicationScoped</option>
                    <option>all-open:annotation=javax.enterprise.context.Dependent</option>
                    <option>all-open:annotation=javax.ejb.Singleton</option>
                    <option>all-open:annotation=javax.ejb.Stateful</option>
                    <option>all-open:annotation=javax.ejb.Stateless</option>
                </pluginOptions>
                <jvmTarget>1.8</jvmTarget>
            </configuration>
            <dependencies>
                <dependency>
                    <groupId>org.jetbrains.kotlin</groupId>
                    <artifactId>kotlin-maven-allopen</artifactId>
                    <version>${kotlin.version}</version>
                </dependency>
            </dependencies>
        </plugin>
    </plugins>
</build>
```
