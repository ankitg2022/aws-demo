FROM maven:3.6.3 AS maven
WORKDIR /usr/src/app
COPY . .
# Compile and package the application to an executable JAR
RUN mvn clean install

# For Java 11,
FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR /opt/app/aws-demo
# Copy the jar file from the maven stage to the /opt/app/aws-demo/aws-demo.jar file of the current stage.
COPY --from=maven /usr/src/app/target/*.jar /opt/app/aws-demo/aws-demo.jar
ENTRYPOINT ["java","-jar","aws-demo.jar"]