require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 既存の production 設定はそのまま
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }
  config.active_storage.service = :local
  config.assume_ssl = true
  config.force_ssl = true
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false
  config.cache_store = :solid_cache_store
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]
  config.i18n.fallbacks = true
  config.action_mailer.default_url_options = { host: "example.com" }

  # -------------------------------
  # Render 上のホスト許可設定
  # -------------------------------

  # ENV で RAILS_HOSTS を設定している場合
  if ENV["RAILS_HOSTS"].present?
    ENV["RAILS_HOSTS"].split(",").each do |host|
      config.hosts << host.strip
    end
  end

  # Render 固定ホストも明示的に追加
  config.hosts << "aki-app-api.onrender.com"

  # 本番で一時的に全ホスト許可する場合（デバッグ用）
  # config.hosts.clear
end
