ARG RUBY_VERSION=3.2.3

FROM ruby:${RUBY_VERSION}-slim-bookworm

ARG GEM_VERSION=3.5.5
ARG BUNDLER_VERSION=2.5.5

ENV APP_PATH /app
ENV BUNDLE_PATH /box

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
    nodejs \
    npm \
    shared-mime-info \
    pkg-config \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN npm i -g yarn
RUN gem update --system ${GEM_VERSION}
RUN gem install bundler -v ${BUNDLER_VERSION}

RUN mkdir $APP_PATH

WORKDIR $APP_PATH
