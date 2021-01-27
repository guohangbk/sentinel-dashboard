# First stage: complete build environment
FROM maven:3.5.0-jdk-8-alpine AS builder

# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./src src/

# package jar
RUN mvn install -Dmaven.test.skip=true

From openjdk:8

# copy jar from the first stage
COPY ./build/libs/*.jar sentinel-dashboard-1.8.0-SNAPSHOT.jar
EXPOSE 8080
CMD ["java", "-jar", "sentinel-dashboard-1.8.0-SNAPSHOT.jar"]
