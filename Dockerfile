FROM node:16-alpine 

WORKDIR /app

COPY package* .
COPY ./prisma .

# Optimising the Docker build process by copying the package.json and package-lock.json files first, and then running npm install. This way, the npm install command will only be re-run if the package.json or package-lock.json files have changed. This will save time during the build process, as the npm install command can be time-consuming.
RUN npm install
RUN npx prisma generate

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["node", "dist/index.js"] 