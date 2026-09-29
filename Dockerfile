FROM node:20-alpine
WORKDOR /app
COPY . .
CMD ["node", "index.js"]