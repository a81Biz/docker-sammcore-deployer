# --- Stage: Clone code (una sola vez) ---
FROM alpine:3.20 AS clone
WORKDIR /src
RUN apk add --no-cache git
# Clona SIEMPRE de la rama master
ARG GIT_URL="https://github.com/a81Biz/sammcore-deployer.git"
ARG GIT_REF="master"
RUN git clone --branch ${GIT_REF} --depth 1 ${GIT_URL} appsrc

# --- Stage: Build frontend ---
FROM node:20-alpine AS build-frontend
WORKDIR /app/frontend
COPY --from=clone /src/appsrc/frontend/ ./
RUN npm install && npm run build

# --- Stage: Build backend ---
FROM golang:1.22-alpine AS build-backend
WORKDIR /app/backend
COPY --from=clone /src/appsrc/backend/ ./
RUN go build -o /app/backend

# --- Stage final (runtime) ---
FROM alpine:3.20
WORKDIR /app
# Binario backend
COPY --from=build-backend /app/backend /app/backend
# Frontend compilado
COPY --from=build-frontend /app/frontend/dist /app/frontend/dist

ENV PORT=8080
EXPOSE 8080

# Nota: el backend debe servir /app/frontend/dist como estático.
CMD ["/app/backend"]
