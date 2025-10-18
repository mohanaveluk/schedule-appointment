#stage 1
FROM node:14-alpine as node
WORKDIR /app
COPY . .
RUN npm install
RUN export NODE_OPTIONS=--openssl-legacy-provider
RUN npm run build-prod
COPY ./web.config /app/dist/schedule-appointment
COPY ./web.config /app/dist/schedule-appointment

#stage 2
FROM nginx:1.20.1
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=node /app/dist/schedule-appointment /usr/share/nginx/html
