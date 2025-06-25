MetaTags.configure do |config|
  # Optimize limits for social media platforms
  config.title_limit        = 60  # Twitter/Facebook optimal length
  config.description_limit  = 160 # Google snippet length, also good for social
  config.keywords_limit     = 255
  config.keywords_separator = ', '
end
