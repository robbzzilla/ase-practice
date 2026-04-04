FROM node:18-bullseye-slim
WORKDIR /usr/src/app

# 1. Install OpenSSL (Debian syntax)
RUN apt-get update && apt-get install -y openssl

# 2. Copy package files and schema
COPY package*.json ./
COPY prisma ./prisma/

# 3. Install dependencies
RUN npm install

# 4. Generate Prisma client
RUN npx prisma generate

# 5. Copy the rest of the code
COPY . .

EXPOSE 8080
CMD [ "node", "index.js" ]
