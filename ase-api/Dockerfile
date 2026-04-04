FROM node:18-bullseye-slim
WORKDIR /usr/src/app

# Install OpenSSL for Debian
RUN apt-get update && apt-get install -y openssl

# Copy everything first
COPY . .

# Delete broken local modules
RUN rm -rf node_modules

# Install and generate natively
RUN npm install
RUN npx prisma generate

EXPOSE 8080
CMD [ "node", "index.js" ]
