FROM node:18-bookworm-slim
WORKDIR /usr/src/app

# Install OpenSSL
RUN apt-get update && apt-get install -y openssl

# Copy package files and install
COPY package*.json ./
COPY prisma ./prisma/
RUN npm install

# Copy the rest of the code
COPY . .

# Force clean generation of the Prisma client
RUN rm -rf node_modules/.prisma
RUN rm -rf node_modules/@prisma/client
RUN npx prisma generate

EXPOSE 8080
CMD [ "node", "index.js" ]
