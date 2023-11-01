# OpenAI.configure do |config|
#   config.access_token =  Rails.application.credentials.openai.access_token
#   config.organization_id = Rails.application.credentials.openai.organization_id
# end

OpenAI.configure do |config|
  config.access_token = ENV['OPENAI_ACCESS_TOKEN']
  config.organization_id = "org-Og9DHM7SL0t4JJmsZ3Pe47fT"
end