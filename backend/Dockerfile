# Stage 1: Build the application using Maven
FROM maven:3.9.5-eclipse-temurin-21 AS build
WORKDIR /app
# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B
# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create a minimal runtime image
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Copy the built jar from the build stage
COPY --from=build /app/target/startup-connect-0.0.1-SNAPSHOT.jar app.jar
# Expose the application port
EXPOSE 8080
# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
