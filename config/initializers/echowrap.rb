keys = YAML.load_file(Rails.root.join('config/api_keys.yml'))
puts keys
Echowrap.configure do |config|
  config.api_key =       keys['echonest_api_key']
  config.consumer_key =  keys['echonest_consumer_key']
  config.shared_secret = keys['echonest_shared_secret']
end
