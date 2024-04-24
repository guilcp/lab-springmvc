# Dockerfile para ambiente de build da aplicação
FROM eclipse-temurin:17-jdk AS build
FROM maven:3.8.2-jdk-11
WORKDIR /app
COPY . .
RUN mvn clean package

# Segundo estágio do Dockerfile para montar o container de execução da aplicação
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/labspringmvc-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
