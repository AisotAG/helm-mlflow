FROM python:3.10-slim-buster

ARG UNAME=cnb
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

USER $UNAME

ENV PATH "$PATH:/home/cnb/.local/bin"

COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

CMD mlflow server --backend-store-uri $BACKEND_STORE_URI --artifacts-destination $ARTIFACTS_DESTINATION --serve-artifacts --host $HOST --port $PORT