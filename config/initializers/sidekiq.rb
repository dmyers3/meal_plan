Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDISTOGO_URL"] || "redis://localhost:6379/", size: 7 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDISTOGO_URL"] || "redis://localhost:6379/", size: 1 }
end