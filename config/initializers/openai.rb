OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
  config.log_errors = true
  config.uri_base = "https://gateway.usevelvet.com/api/openai/v1/"
  config.extra_headers = {
    "velvet-auth": ENV.fetch("VELVET_API_KEY"),
    "velvet-metadata-env": Rails.env
  }
end
