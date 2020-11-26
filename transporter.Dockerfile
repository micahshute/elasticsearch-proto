FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install wget && \
    wget https://github.com/compose/transporter/releases/download/v0.5.2/transporter-0.5.2-linux-amd64 && \
    mv transporter-*-linux-amd64 /usr/local/bin/transporter && \
    chmod +x /usr/local/bin/transporter && \
    transporter init mongodb elasticsearch

ENV MONGODB_URI=http://mongo:27017
ENV ELASTICSEARCH_URI=http://search:9200