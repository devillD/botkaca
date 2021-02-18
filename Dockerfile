FROM ubuntu:20.04

RUN mkdir ./app
RUN chmod 777 ./app
WORKDIR /app
RUN apt -qq update

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Dhaka
RUN apt -qq install -y curl git wget \
    python3 python3-pip \ 
    libffi7 libffi-dev musl-dev \ 
    gcc aria2 ffmpeg
RUN pip3 install -q --ignore-installed distlib pipenv

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY bot bot

CMD ./start.sh
