FROM node:18-alpine
WORKDIR /usr/src/app

# 1. Install OpenSSL (Required for Prisma on Alpine Linux)
RUN apk add --no-cache openssl

# 2. Copy package files AND the prisma schema
COPY package*.json ./
COPY prisma ./prisma/

# 3. Install dependencies
RUN npm install

# 4. Generate the Prisma client explicitly
RUN npx prisma generate

# 5. Copy the rest of your API code
COPY . .

EXPOSE 8080
CMD [ "node", "index.js" ]
