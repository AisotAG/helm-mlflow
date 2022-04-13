FROM python:3.10-slim-buster

ARG UNAME=cnb
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

USER $UNAME

# Pip dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

ENV BACKEND_STORE_URI=""

ENV PATH "$PATH:/home/cnb/.local/bin"

# Port
EXPOSE 80

CMD mlflow server --host 0.0.0.0 --port 80 --backend-store-uri $BACKEND_STORE_URI --serve-artifacts --artifacts-destination /mnt/aksshare/mlflow