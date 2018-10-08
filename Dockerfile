FROM python:3.6-alpine

COPY zappa_settings.json /root/zappa_settings.json
COPY aws /root/.aws
COPY main.py /root/main.py
COPY requirements.txt /root/requirements.txt

WORKDIR /root

RUN pip3 install virtualenv
RUN virtualenv serverlessbot && \
    source serverlessbot/bin/activate && \
    pip3 install -r /root/requirements.txt && \
    deactivate
