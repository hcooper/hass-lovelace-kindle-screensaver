FROM node:16-alpine3.11

WORKDIR /app

RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    imagemagick

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    USE_IMAGE_MAGICK=true

COPY package*.json ./

RUN npm ci

COPY *.js ./

CMD mkdir www
COPY www/* ./www/

COPY run.sh ./
CMD chmod +x ./run.sh

EXPOSE 5000

CMD ./run.sh