# --- Stage: clone code ---
FROM alpine:3.20 AS clone
WORKDIR /src
RUN apk add --no-cache git
RUN git clone --branch master --depth 1 https://github.com/a81Biz/sammcore-deployer.git appsrc

# --- Stage: build frontend ---
FROM node:20-alpine AS build-frontend
WORKDIR /app
COPY --from=clone /src/appsrc/frontend/ ./
RUN npm install && npm run build

# --- Runtime with NGINX ---
FROM nginx:1.27-alpine
COPY --from=build-frontend /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

