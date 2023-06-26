FROM maven:3.6.3 AS maven
WORKDIR /usr/src/app
COPY . .
# Compile and package the application to an executable JAR
RUN mvn clean install

# For Java 11,
FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR /opt/app/ankit-ghcr-ecs-automation
# Copy the jar file from the maven stage to the /opt/app/ankit-ghcr-ecs-automation/ankit-ghcr-ecs-automation.jar file of the current stage.
COPY --from=maven /usr/src/app/target/*.jar /opt/app/ankit-ghcr-ecs-automation/ankit-ghcr-ecs-automation.jar
ENTRYPOINT ["java","-jar","ankit-ghcr-ecs-automation.jar"]