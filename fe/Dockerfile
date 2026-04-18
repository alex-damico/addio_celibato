FROM ghcr.io/cirruslabs/flutter:3.41.6 AS build

WORKDIR /app

COPY . .

# Abilito web (di solito già attivo)
RUN flutter config --enable-web

# Scarico dipendenze
RUN flutter pub get

# Build web (release)
RUN flutter build web --release


FROM nginx:alpine

# Rimuovo config default
RUN rm -rf /usr/share/nginx/html/*

# Copio build flutter
COPY --from=build /app/build/web /usr/share/nginx/html

# Copio config custom (opzionale ma consigliato)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]