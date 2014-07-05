require 'lastfm'

# Lfm to avoid name clash with gem
class Lfm
  attr_reader :lastfm

  def initialize
    @lastfm = Lastfm.new(ENV['LASTFM_KEY'], ENV['LASTFM_SECRET'])
  end

  # {user: 'echowarpt', period: '7day', limit: 50}
  def top_tracks(options)
    Rails.cache.fetch("lastfm-#{options.values.split('-')}", expires_in: 1.hour) do
      tracks = @lastfm.user.get_top_tracks(options)
      Rails.logger.info(tracks.size)
      Rails.logger.info(tracks.map{|t| t['name']})
      tracks
      #tracks[0..100]
    end
  end
end
