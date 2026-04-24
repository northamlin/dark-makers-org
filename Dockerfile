FROM node:22-alpine
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json ./
RUN yarn global add node-gyp
RUN yarn install --frozen-lockfile

WORKDIR /opt/app
COPY . .
RUN yarn build
RUN chown -R node:node /opt/app
USER node

EXPOSE 1337
ENV HOST=0.0.0.0
ENV PORT=1337
CMD ["yarn", "start"]
