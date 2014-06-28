class Playlist
  def initialize
    @api = Rails.application.config.echonest_api_key
  end

  def hottt
    song = Echonest::Song.new(Rails.application.config.echonest_api_key)
    songs = song.search(bucket: ['id:spotify', 'tracks', 'song_hotttnesss_rank'], 
                        sort: ['song_hotttnesss-desc'], 
                        results:50)
    us = {}
    songs.each do |song|
      key = "#{song[:artist_name]} - #{song[:title]}"
      us[key] = song unless song[:tracks].empty?
    end
    spotify_uris = []
    us.each {|title, song| spotify_uris << song[:tracks].first[:foreign_id].split(':')[-1] }
    spotify_uris
  end
end
