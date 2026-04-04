FROM node:18-alpine
WORKDIR /usr/src/app

# 1. Copy package files AND the prisma schema first
COPY package*.json ./
COPY prisma ./prisma/

# 2. Install dependencies
RUN npm install

# 3. Generate the Prisma client explicitly
RUN npx prisma generate

# 4. Copy the rest of your API code
COPY . .

EXPOSE 8080
CMD [ "node", "index.js" ]
