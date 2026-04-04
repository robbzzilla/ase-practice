FROM node:18-bullseye-slim
WORKDIR /usr/src/app

# Install OpenSSL for Debian
RUN apt-get update && apt-get install -y openssl

# Copy package files and install dependencies
COPY package*.json ./
COPY prisma ./prisma/
RUN npm install

# Copy the rest of the code
COPY . .

# FORCE DELETE the cached Prisma client, then regenerate natively
RUN rm -rf node_modules/.prisma
RUN rm -rf node_modules/@prisma/client
RUN npx prisma generate

EXPOSE 8080
CMD [ "node", "index.js" ]
