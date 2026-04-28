# Build stage
FROM ghcr.io/cirruslabs/flutter:3.41.6 AS build

WORKDIR /app

COPY pubspec.yaml pubspec.lock* ./
RUN flutter pub get

COPY . .

RUN flutter config --enable-web
ARG BASE_URL=/api
RUN flutter build web --release --dart-define=BASE_URL=$BASE_URL


# Runtime stage
FROM nginx:alpine

# Rimuovi default e copia il build
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build/web /usr/share/nginx/html

# Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]