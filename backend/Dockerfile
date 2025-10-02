# --- Stage: clone code ---
FROM alpine:3.20 AS clone
WORKDIR /src
RUN apk add --no-cache git
RUN git clone --branch master --depth 1 https://github.com/a81Biz/sammcore-deployer.git appsrc

# --- Stage: build Go backend ---
FROM golang:1.22-alpine AS build-backend
WORKDIR /app
COPY --from=clone /src/appsrc/backend/ ./backend/
WORKDIR /app/backend
RUN go mod tidy && go build -o /app/backend main.go

# --- Runtime image ---
FROM alpine:3.20
WORKDIR /app
COPY --from=build-backend /app/backend /app/backend
EXPOSE 8080
CMD ["/app/backend"]
