
FROM node:22.20.0-bookworm-slim

ENV NODE_ENV=production

WORKDIR /app

COPY --chown=node:node app/ ./

USER node

EXPOSE 3000

CMD ["npm", "start"]
