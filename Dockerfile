FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar
COPY src/main/resources/application.properties /app/application.properties
COPY src/main/resources/static /app/static

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "demo.jar"]
