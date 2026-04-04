FROM node:18-bookworm-slim
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y openssl

COPY package*.json ./
COPY prisma ./prisma/
RUN npm install

COPY . .

RUN rm -rf node_modules/.prisma
RUN rm -rf node_modules/@prisma/client
RUN npx prisma generate

EXPOSE 8080
CMD [ "node", "index.js" ]
