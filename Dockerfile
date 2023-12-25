FROM gradle:7-jdk11 as build
COPY --chown=gradle:gadle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle buildFatJar --no-daemon

FROM openjdk:11
EXPOSE 8090:8080
#EXPOSE [external:internal]
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/ktor-websocket-sample.jar
ENTRYPOINT ["java", "-jar", "/app/ktor-websocket-sample.jar"]
