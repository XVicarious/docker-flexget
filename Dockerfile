FROM wiserain/flexget
RUN apk add --no-cache build-base libxml2 libxml2-dev python3-dev libxslt libxslt-dev mediainfo &&\
    pip install python-slugify mechanicalsoup lxml pymediainfo fuzzywuzzy[speedup] &&\
    apk del libxml2-dev libxslt-dev python3-dev
