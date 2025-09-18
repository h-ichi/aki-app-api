Rails.application.configure do
  # コードをキャッシュ
  config.cache_classes = true
  config.eager_load = true

  # エラー画面は最小限
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # 静的ファイルは Rails が配信
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # ログレベル
  config.log_level = :info

  # デフォルトホスト
  config.hosts << ENV.fetch("RENDER_EXTERNAL_HOSTNAME") { "your-app.onrender.com" }

  # Secret key base
  config.require_master_key = true
end
