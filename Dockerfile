# Dockerfile
FROM ruby:3.2

# 必要パッケージ
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 作業ディレクトリ
WORKDIR /aki_finder_api

# Gemfileコピー & bundle install
COPY Gemfile* ./
RUN bundle install

# アプリコピー
COPY . .

# サーバー起動
CMD ["rails", "s", "-b", "0.0.0.0"]
