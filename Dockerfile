FROM ruby:slim-bookworm

WORKDIR /app

RUN mkdir /search/

COPY ./app/  ./

ENTRYPOINT [ "ruby", "server.rb" ]
