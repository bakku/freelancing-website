FROM ruby:3.2.2-alpine AS builder

WORKDIR /site

RUN apk update && \
    apk add build-base

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN bundle exec jekyll build

FROM nginx:1.25.3-alpine AS production

COPY --from=builder /site/_site /usr/share/nginx/html