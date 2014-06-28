class Playlist
  def initialize
    @api = Rails.application.config.echonest_api_key
    @song = Echonest::Song.new(@api)
  end

  def hottt
    songs = @song.search(bucket: ['id:spotify', 'tracks', 'song_hotttnesss_rank'], 
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

  def taste_playlist_from_tracks
    spotify_uris = tracks_hash.each_with_object([]) do |t, arr|
      results = @song.search(bucket: ['id:spotify', 'tracks'],
                          title: t[:title],
                          artist: t[:artist],
                         results: 20)
      tracks = results.find{|h| !h[:tracks].empty?}
      spotify_uri = tracks[:tracks].first[:foreign_id].split(':')[-1] unless tracks.nil? || tracks.empty?
      arr << spotify_uri unless spotify_uri.nil?
    end
  end


  private

  def tracks_hash
    tracks = [
      ["Unsung","Helmet ","Unsung: The Best Of Helmet 1991-1997"],
      ["Fuck Authority","Pennywise ","Land Of The Free?"],
      ["Time Marches On","Pennywise ","Land Of The Free?"],
      ["Paranoid","Black Sabbath ","Complete Studio Albums 1970-1978"],
      ["Jack The Stripper/Fairies Wear Boots","Black Sabbath ","Complete Studio Albums 1970-1978"],
      ["Closer","Nine Inch Nails ","The Downward Spiral"],
      ["The Hand That Feeds","Nine Inch Nails ","With Teeth"],
    ]
    tracks.each_with_object([]) {|t, arr| arr << {title: t[0], artist: t[1], album: t[2]} }
  end
end
