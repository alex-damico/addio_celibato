# Stage 1: Build dell'applicazione
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app

RUN apk add --no-cache binutils

# ✅ Layer 1: Copia solo i file di configurazione Maven
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN chmod +x mvnw

# ✅ Layer 2: Scarica dipendenze (rimane in cache se pom.xml non cambia)
RUN ./mvnw dependency:go-offline -B -q

# ✅ Layer 3: Copia il codice sorgente (invalida solo se src/ cambia)
COPY src src

# ✅ Layer 4: Build
RUN ./mvnw clean package -DskipTests -q

## Stage 2: Creazione JRE personalizzato (con tanto spazio)
#FROM eclipse-temurin:21-jre
#
#WORKDIR /app
#
#COPY --from=build /app/target/*.jar app.jar
#ENV SERVER_URL=http://localhost:8080
#
#ENTRYPOINT ["java","-jar","app.jar"]

# Stage 2: JRE personalizzato
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

RUN apk add --no-cache libstdc++ gcompat curl

ENV JAVA_HOME=/opt/java-runtime
ENV PATH="$JAVA_HOME/bin:$PATH"
ENV SERVER_URL=http://localhost:8080

COPY --from=build /javaruntime $JAVA_HOME
COPY --from=build /app/target/*.jar app.jar

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
