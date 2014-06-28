require 'rockstar'

class Lastfm
  def initialize
    config = YAML.load_file(Rails.root.join('config/api_keys.yml'))
    Rockstar.lastfm = {
      api_key: config['lastfm_key'],
      api_secret: config['lastfm_secret']
    }
  end

  def top_weekly_tracks(user)
    Rails.cache.fetch("rockstar-#{user}", expires_in: 1.day) do
      user = Rockstar::User.new(user)
      user.weekly_track_chart[10]
    end
  end
end
