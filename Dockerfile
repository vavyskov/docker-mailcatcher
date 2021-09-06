FROM alpine:3.13

ARG TZ=Europe/Prague

ENV MAILCATCHER_VERSION=0.7.1
ENV TIME_ZONE ${TZ}
#ENV LANG="cs_CZ.UTF-8"
#ENV LC_ALL="cs_CZ.UTF-8"
#ENV LANGUAGE="cs_CZ.UTF-8"

RUN echo "Setting the timezone..." \
&&  apk add --no-cache --virtual .build-deps \
        tzdata \
&&  cp /usr/share/zoneinfo/${TZ} /etc/localtime \
#&&  ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
&&  apk del --purge .build-deps

RUN apk add --no-cache \
        #ca-certificates \
        #openssl \
        ruby \
        ruby-bigdecimal \
        ruby-etc \
        ruby-json \
        libstdc++ \
        sqlite-libs

RUN apk add --no-cache --virtual .build-deps \
        ruby-dev \
        make \
        g++ \
        sqlite-dev \
&&  gem install mailcatcher -v $MAILCATCHER_VERSION --no-document \
&&  apk del --purge .build-deps

## Initialize container
COPY config/entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
#ENTRYPOINT [ "entrypoint.sh", "docker-php-entrypoint" ]

EXPOSE 1025 1080

CMD ["mailcatcher", "--foreground", "--no-quit", "--ip=0.0.0.0", "--smtp-port=1025", "--http-port=1080"]
