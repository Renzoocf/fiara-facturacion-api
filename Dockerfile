FROM php:8.1-cli-alpine

WORKDIR /app

RUN apk add --no-cache \
    git \
    unzip \
    curl \
    libxml2-dev

RUN docker-php-ext-install soap pcntl

# Descargar e instalar Lycet oficial directamente desde GitHub
RUN git clone https://github.com/giansalex/lycet.git /app

# Instalar Composer y dependencias PHP oficiales de Lycet
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer install --no-interaction --no-dev --optimize-autoloader

ENV APP_ENV=prod
ENV CLIENT_TOKEN=123456
ENV SOL_USER=20000000001MODDATOS
ENV SOL_PASS=MODDATOS
ENV FE_URL=https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService

EXPOSE 8000

CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
