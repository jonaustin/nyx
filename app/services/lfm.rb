require 'lastfm'

# Lfm to avoid name clash with gem
class Lfm
  attr_reader :lastfm

  def initialize
    @lastfm = Lastfm.new(ENV['LASTFM_KEY'], ENV['LASTFM_SECRET'])
  end

  # {user: 'echowarpt', period: '7day', limit: 50, start: 0}
  # note: spotify playlists don't seem to be created (i.e. spotify iframe doesn't show on page)
  #   if there are more than ~90 tracks -- even though limit is supposed to be 200
  #   https://developer.spotify.com/technologies/widgets/spotify-play-button/
  #   Until I can figure out a more clever solution, prob safest to keep limit at 80.
  def top_tracks(options)
    limit_to_fetch = options[:start] + options[:limit]
    Rails.cache.fetch("lastfm-#{options.values.split('-')}", expires_in: 1.hour) do
      tracks = @lastfm.user.get_top_tracks(options.merge(limit: limit_to_fetch))
      Rails.logger.info(tracks.size)
      Rails.logger.info(tracks.map{|t| t['name']})
      tracks.slice(options[:start].to_i, options[:limit].to_i)
    end
  end

  def user(username)
    begin
      @lastfm.user.get_info(user: username)
    rescue Lastfm::ApiError
      {error: true}
    end
  end
end
