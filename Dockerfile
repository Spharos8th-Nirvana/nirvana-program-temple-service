FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew bootJar -x test --no-daemon
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "build/libs/app.jar"]
