FROM python:3.7-alpine

RUN apk update \
    && apk add --no-cache \
        libpq \
    && apk add --no-cache --virtual build-deps \
        gcc \
        musl-dev \
        postgresql-dev

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

COPY . /opt/app
COPY .env.example /opt/app/.env

RUN apk del build-deps

WORKDIR /opt/app

CMD ["python", "main.py"]
