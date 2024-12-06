FROM ruby:slim-bookworm

WORKDIR /app

RUN mkdir /search/

COPY ./app/  ./

EXPOSE 80

ENTRYPOINT [ "ruby", "server.rb" ]
