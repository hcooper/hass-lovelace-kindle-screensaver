FROM node:16-alpine3.17

WORKDIR /app

RUN apk add --no-cache \
    chromium \
    nss \
    freetype \    
    font-noto-emoji \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    imagemagick

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    USE_IMAGE_MAGICK=true

COPY package*.json ./
COPY local.conf /etc/fonts/local.conf

RUN npm ci

COPY *.js ./


# Seriously. Like WTF the does docker COPY do to directories?!?!
CMD mkdir www
CMD mkdir www/kindle-wifi
COPY www/kindle-sleep-duration www/
COPY www/screenshot_server_is_on_port_8080 www/
COPY www/kindle-wifi/wifistub-eink.html www/kindle-wifi/
COPY www/kindle-wifi/wifistub.html www/kindle-wifi/

COPY run.sh ./
CMD chmod +x ./run.sh

EXPOSE 5000

CMD ./run.sh