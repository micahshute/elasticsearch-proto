FROM ruby:2.5

RUN mkdir /app && \
    gem install mongo

COPY . /app

WORKDIR /app

CMD ["./import_data"]