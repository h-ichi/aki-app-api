FROM ruby:3.2

# NodeJS & Yarn（JavaScript依存用）
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

# 作業ディレクトリ
WORKDIR /aki_finder_api

# Gemfileコピー & bundle install
COPY Gemfile* ./
RUN bundle install

# アプリコードコピー
COPY . .

# ポート公開
EXPOSE 3000

# サーバ起動
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
