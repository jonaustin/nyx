require 'echowrap'

class Playlist
  def initialize
    @en = Echowrap
  end

  def hottt
    Rails.cache.fetch('en-hottt', expires_in: 1.day) do
      en_songs = @en.song_search(bucket: ['id:spotify', 'tracks', 'song_hotttnesss_rank'], 
                              sort: ['song_hotttnesss-desc'], 
                              results:50)
      en_songs.each_with_object([]) do |song, spotify_uris|
        next if song.tracks.empty?
        spotify_uris << song.tracks.first.foreign_id.split(':')[-1]
      end
    end
  end

  def taste_playlist_from_tracks(tracks=tracks_hash)
    Rails.cache.fetch("taste_playlist_from_tracks-#{tracks.to_json}", expires_in: 10.days) do
      tracks_hash.each_with_object([]) do |t, arr|
        results = @en.song_search(bucket: ['id:spotify', 'tracks'],
                                  title: t[:title],
                                  artist: t[:artist],
                                  results: 20)
        result = results.find{|h| !h.tracks.empty?}
        spotify_uri = result.tracks.first.foreign_id.split(':')[-1] unless results.nil? || results.empty?
        arr << spotify_uri unless spotify_uri.nil?
      end
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
