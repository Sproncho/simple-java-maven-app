FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /opt/app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21.0.8_9-jre-alpine AS final
WORKDIR /opt/app
EXPOSE 8080
COPY --from=builder /opt/app/target/*.jar /opt/app/app.jar
ENTRYPOINT ["java", "-jar", "/opt/app/app.jar"]