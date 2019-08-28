FROM alpine

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
&&  gem install mailcatcher --no-ri --no-rdoc \
&&  apk del --purge .build-deps

EXPOSE 25 80

CMD ["mailcatcher", "--foreground", "--no-quit", "--ip=0.0.0.0", "--smtp-port=25", "--http-port=80"]
