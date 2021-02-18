FROM ubuntu:20.04

RUN mkdir ./app
RUN chmod 777 ./app
WORKDIR /app
RUN apt -qq update

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Dhaka

RUN apt -qq install -y python3 python3-dev python3-pip libffi libffi-dev musl-dev gcc aria2 ffmpeg
RUN pip3 install -q --ignore-installed distlib pipenv
RUN python3 -m venv /app/venv

ENV PATH="/app/venv/bin:$PATH" VIRTUAL_ENV="/app/venv"
COPY requirements.txt .
RUN RUN pip3 install --no-cache-dir -r requirements.txt

COPY --from=prepare_env /app/venv venv
COPY bot bot

CMD ["python3", "-m", "bot"]
