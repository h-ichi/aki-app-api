# Ruby 3.2.2 ベース
FROM ruby:3.2.2

# 必須パッケージ、Node.js、Yarn、Postgres クライアント
RUN apt-get update -qq && apt-get install -y \
    curl \
    gnupg2 \
    build-essential \
    libpq-dev \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq && apt-get install -y yarn postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリ
WORKDIR /app

# Gemfile を先にコピーして bundle install（キャッシュ効率化）
COPY Gemfile* ./
RUN bundle install

# アプリケーションコードをコピー
COPY . .

# Rails サーバー公開ポート
EXPOSE 3000

# デフォルトコマンド
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
