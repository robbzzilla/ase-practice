FROM node:18-bullseye-slim
WORKDIR /usr/src/app

# 1. Install OpenSSL for Debian
RUN apt-get update && apt-get install -y openssl

# 2. Copy ALL files from your local machine into the container
COPY . .

# 3. Force delete any broken node_modules that accidentally got copied
RUN rm -rf node_modules
RUN rm -rf .next

# 4. Install fresh dependencies and generate Prisma natively inside Debian
RUN npm install
RUN npx prisma generate

EXPOSE 8080
CMD [ "node", "index.js" ]
