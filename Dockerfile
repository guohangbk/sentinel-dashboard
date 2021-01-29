# First stage: complete build environment
FROM maven:3.5.0-jdk-8-alpine AS builder

# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./src src/

# package jar
RUN mvn install -Dmaven.test.skip=true

From openjdk:8
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# copy jar from the first stage
COPY --from=builder target/sentinel-dashboard.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["sh","-c","java -server -jar -Duser.timezone=GMT+08 /app/app.jar"]
