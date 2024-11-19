FROM node:20
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build && npm install -g serve
CMD ["serve", "-s", "build", "-l", "80"]
