# build stage
FROM node:22 AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
# ENTRYPOINT ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# serve stage
FROM nginx:latest
COPY --from=build /app/dist /usr/share/nginx/html