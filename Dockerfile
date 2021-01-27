From openjdk:8

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ./build/libs/*.jar /app/app.jar
ENV RUNENV=""
ENV JVMARG=""
ENTRYPOINT ["sh","-c","java -server -jar $JVMARG -Duser.timezone=GMT+08 /app/app.jar --spring.profiles.active=$RUNENV"]
