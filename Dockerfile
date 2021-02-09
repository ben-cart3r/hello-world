## Cache dependency image

FROM alpine:3.11 as dependencies

RUN apk add --no-cache jq

COPY package*.json ./

RUN (jq '{ dependencies, devDependencies }') < package.json > deps.json
RUN (jq '.version = "1.0.0"' | jq '.packages."".version = "1.0.0"') < package-lock.json > deps-lock.json

## Builder image

FROM alpine:3.11 as builder

RUN apk add --update nodejs nodejs-npm

WORKDIR /app

COPY --from=dependencies deps.json package.json
COPY --from=dependencies deps-lock.json package-lock.json

RUN npm clean-install

COPY src src/
COPY tsconfig.json .
COPY package.json .

RUN npm run build

## Production Image

FROM alpine:3.11

ENV PORT 3000
ENV NODE_ENV production

RUN apk add --update nodejs nodejs-npm

WORKDIR /app

COPY --from=dependencies deps.json package.json
COPY --from=dependencies deps-lock.json package-lock.json

RUN npm clean-install --only=production

COPY --from=builder /app/dist dist/
COPY package.json .

CMD ["npm", "start"]