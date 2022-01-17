FROM ubuntu:20.04

RUN apt update -y && apt install -y ssh

WORKDIR /app

COPY . /app

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
