# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the executable JAR file from the host to the container
COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "demo.jar"]