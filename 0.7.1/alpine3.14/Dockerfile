ARG ALPINE_VERSION=3.14

FROM alpine:${ALPINE_VERSION}

ARG TZ=Europe/Prague

ENV MAILCATCHER_VERSION=0.7.1
ENV TIME_ZONE ${TZ}

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

EXPOSE 25 80

CMD ["mailcatcher", "--foreground", "--no-quit", "--ip=0.0.0.0", "--smtp-port=25", "--http-port=80"]
