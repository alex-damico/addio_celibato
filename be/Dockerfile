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

# Stage 2: Creazione JRE
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
ENV SERVER_URL=http://localhost:8080

ENTRYPOINT ["java","-jar","app.jar"]
