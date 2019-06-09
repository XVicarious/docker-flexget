FROM alpine:3.9
MAINTAINER Brian Maurer aka XVicarious
ENV DEPS="python3 ca-certificates tzdata py3-cryptography mediainfo libxml2 libxslt"
RUN apk add --no-cache $DEPS &&\
    python3 -m ensurepip &&\
    rm -r /usr/lib/python*/ensurepip &&\
    pip3 install --upgrade pip setuptools &&\
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi &&\
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python ; fi
ENV BUILD_DEPS="build-base python3-dev libxml2-dev libxslt-dev linux-headers"
ENV PYTHON_PKG="flexget transmissionrpc python-telegram-bot python-slugify mechanicalsoup lxml fuzzywuzzy[speedup] pymediainfo psutil pysnooper cloudscraper cachecontrol"
RUN apk add --no-cache $BUILD_DEPS &&\
    pip install $PYTHON_PKG &&\
    apk del --no-cache --purge $BUILD_DEPS &&\
    rm -rf /tmp/* /root/.cache /var/cache/apk/*
VOLUME /config /data
ENV FLEXGET_LOGLEVEL=info
WORKDIR /config
EXPOSE 3539 3539/tcp
COPY root/ /
RUN chmod +x /scripts/init.sh
CMD ["/scripts/init.sh"]
