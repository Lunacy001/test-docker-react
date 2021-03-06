#build phase
FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# deploy phase
FROM nginx
# exposing port 80 from the docker container. EBS looks
# at this 'expose' variable and will automatically do the port mapping. This is not equivalent to
# -p 8000:80 or -p 8000:8080 when running in local.
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html