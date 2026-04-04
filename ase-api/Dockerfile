FROM node:18-bullseye-slim
WORKDIR /usr/src/app

# Install OpenSSL for Debian
RUN apt-get update && apt-get install -y openssl

COPY package*.json ./
COPY prisma ./prisma/

RUN npm install
RUN npx prisma generate

COPY . .

EXPOSE 8080
CMD [ "node", "index.js" ]
