# =========================
# 1. Frontend build
# =========================
FROM node:20-alpine AS frontend

WORKDIR /frontend

COPY frontend/ .

RUN npm ci && npm run build


# =========================
# 2. Backend build
# =========================
FROM eclipse-temurin:21-jdk AS backend

WORKDIR /app

COPY . .

RUN chmod +x gradlew

# Кладём React туда, откуда Spring Boot раздаёт static
COPY --from=frontend /frontend/dist ./src/main/resources/static

RUN ./gradlew build


# =========================
# 3. Final image
# =========================
FROM eclipse-temurin:21-jre AS final

WORKDIR /app

COPY --from=backend /app/build/libs/*.jar ./app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]