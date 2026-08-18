# =========================
# 1. Backend build
# =========================
FROM eclipse-temurin:21-jdk AS backend

WORKDIR /app

COPY . .

RUN ./gradlew build


# =========================
# 2. Frontend build
# =========================
FROM node:20 AS frontend

WORKDIR /frontend

COPY frontend/ .

RUN npm install
RUN npm run build


# =========================
# 3. Final image
# =========================
FROM eclipse-temurin:21-jre AS final

WORKDIR /app

COPY --from=backend /app/build/libs/*.jar ./app.jar
#COPY --from=frontend /frontend/dist ./dist
COPY --from=frontend /frontend/dist ./static


EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]