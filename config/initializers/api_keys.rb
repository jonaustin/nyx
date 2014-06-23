require 'yaml'
yaml = YAML.load_file(Rails.root + 'config/api_keys.yml')
Rails.application.config.echonest_api_key = yaml['echonest_api_key']
