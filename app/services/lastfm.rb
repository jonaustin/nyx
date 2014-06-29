require 'rockstar'

class Lastfm
  def initialize
    Rockstar.lastfm = {
      api_key:    ENV['LASTFM_KEY'],
      api_secret: ENV['LASTFM_SECRET']
    }
  end

  def top_weekly_tracks(user)
    Rails.cache.fetch("rockstar-#{user}", expires_in: 1.hour) do
      user = Rockstar::User.new(user)
      user.weekly_track_chart[0..100]
    end
  end
end
