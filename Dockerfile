FROM node:18.20-alpine

WORKDIR /usr/src/app

RUN apk add --no-cache --virtual .gyp \
	python3 \
	make \
	g++ \
	&& ln -sf python3 /usr/bin/python

COPY --chown=node:node package.json yarn.lock ./
RUN yarn install --production

USER node
COPY --chown=node:node . .
ENV NODE_ENV production

CMD ["node", "mine.js"]