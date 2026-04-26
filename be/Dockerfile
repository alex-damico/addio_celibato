# Stage 1: Build dell'applicazione
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app

# Necessario per jlink --strip-debug
RUN apk add --no-cache binutils

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN chmod +x mvnw && ./mvnw dependency:go-offline

COPY src src
RUN ./mvnw clean package -DskipTests

## Stage 2: Creazione JRE personalizzato (con tanto spazio)
#FROM eclipse-temurin:21-jre
#
#WORKDIR /app
#
#COPY --from=build /app/target/*.jar app.jar
#ENV SERVER_URL=http://localhost:8080
#
#ENTRYPOINT ["java","-jar","app.jar"]

# Stage 2: Creazione JRE personalizzato
RUN jlink \
    --add-modules java.base,java.logging,java.naming,java.desktop,java.management,java.security.jgss,java.instrument,java.sql,java.xml,jdk.unsupported,java.sql.rowset,java.net.http,jdk.naming.dns,java.security.sasl,java.compiler,java.rmi \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=zip-9 \
    --output /javaruntime

# Stage 3: Immagine finale
FROM alpine:latest
WORKDIR /app

# curl per healthcheck, libstdc++ e gcompat per Java su Alpine
RUN apk add --no-cache libstdc++ gcompat curl

ENV JAVA_HOME=/opt/java-runtime
ENV PATH="$JAVA_HOME/bin:$PATH"
ENV SERVER_URL=http://localhost:8080

COPY --from=build /javaruntime $JAVA_HOME
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
