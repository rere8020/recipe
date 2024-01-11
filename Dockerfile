FROM python:3.9-alpine3.13
LABEL maintainer="Rene"

ENV PYTHONUNBUFFERED 1
ARG DEV=false

COPY requirements.txt /tmp/
COPY requirements.dev.txt /tmp/

WORKDIR /app

COPY app/ .

EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
    build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [[ ${DEV} == "true" ]]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"

USER django-user
