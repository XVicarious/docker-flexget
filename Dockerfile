FROM alpine:3.8
MAINTAINER Brian Maurer aka XVicarious
RUN apk add --no-cache \
	python3 \
	ca-certificates \
	tzdata \
	py3-cryptography \
	mediainfo \
	libxml2 \
	libxslt &&\
    python3 -m ensurepip &&\
    rm -r /usr/lib/python*/ensurepip &&\
    pip3 install --upgrade pip setuptools &&\
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi &&\
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python ; fi &&\
    apk add --no-cache \
	build-base \
	python3-dev \
	libxml2-dev \
	libxslt-dev &&\
    pip install --upgrade \
        pip \
	flexget \
    	transmissionrpc \
	python-telegram-bot \
	python-slugify \
	mechanicalsoup \
	lxml \
	fuzzywuzzy[speedup] \
	pymediainfo &&\
    apk del \
    	build-base \
	python3-dev \
	libxml2-dev \
	libxslt-dev &&\
    rm -rf /tmp/* /root/.cache
VOLUME /config /data
ENV FLEXGET_LOGLEVEL=info
WORKDIR /config
EXPOSE 3539 3539/tcp
COPY root/ /
RUN chmod +x /scripts/init.sh
CMD ["/scripts/init.sh"]
