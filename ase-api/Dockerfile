FROM node:20
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npx prisma@5 generate
EXPOSE 8080
CMD ["node", "index.js"]
