# Start from the alpine image
FROM ubuntu:24.04

WORKDIR /usr/src/app

COPY script.sh .

RUN apt-get update
RUN apt-get install -y curl
CMD ["./script.sh"]
