FROM node:latest

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm install --only=production
RUN apt-get update && apt-get install -y cron
RUN echo "*/2 * * * * node /usr/src/app/src/app.js >> /usr/src/app/cron.log 2>&1" > /etc/cron.d/app-cron
RUN chmod 0644 /etc/cron.d/app-cron
CMD ["cron", "-f"]