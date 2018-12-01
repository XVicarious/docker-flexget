FROM wiserain/flexget
RUN apk add --no-cache build-base libxml2-dev python3-dev libxslt-dev
RUN pip install python-slugify mechanicalsoup lxml
