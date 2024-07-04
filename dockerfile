FROM python:3.11-alpine3.18
LABEL maintainer="devmarcosserra@gmail.com"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk add --no-cache netcat-openbsd

COPY djangoapp /djangoapp
COPY scripts /scripts

WORKDIR /djangoapp

RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /djangoapp/project/configurations/requirements.txt && \
    adduser --disabled-password --no-create-home duser && \
    mkdir -p /data/web/static /data/web/media && \
    chown -R duser:duser /venv /data/web/static /data/web/media && \
    chmod -R 755 /data/web/static /data/web/media && \
    chmod -R +x /scripts && \
    chmod +x /scripts/commands.sh

ENV PATH="/scripts:/venv/bin:$PATH"

USER duser

CMD ["/scripts/commands.sh"]
