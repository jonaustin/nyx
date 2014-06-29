require 'echowrap'

class Playlist
  def initialize
    @en = Echowrap
  end

  def hottt(results_limit = 50)
    results_limit += results_limit/2 # account for duplicates (there are a lot)
    uniqs = {}
    en_songs = fetch(bucket: ['id:spotify', 'tracks', 'song_hotttnesss_rank'],
                     sort: ['song_hotttnesss-desc'],
                     results: results_limit,
                     limit: true) # weird: without limit param (false) and results:50 it only returns 16 results, apparently need the limit param to return all results?

    en_songs.each_with_object([]) do |en_song, spotify_uris|
      # EchoNest Bug: there is no way to distinguish between certain titles -- i.e. "Summertime Saddness" and "Summertime Saddness - Cedric Gervais Remix" _both_ have a title of just 'Summertime Sadness'.
      # http://developer.echonest.com/forums/thread/1347
      rank = en_song.attrs[:song_hotttnesss_rank] # Echowrap gem bug: this should be available as a method
      if en_song.tracks \
        && !en_song.tracks.empty? \
        && !uniqs.key?(rank) \
        && uniqs.length <= results_limit
        spotify_uris << spotify_uri_from_echonest_song(en_song)
      end
      uniqs[rank] = nil # see thread above - duplicates will have same rank
    end
  end

  # tracks = [{title: 'title', artist: 'artist'},...]
  def spotify_playlist_from_tracks(tracks=tracks_hash)
    tracks.each_with_object([]) do |t, spotify_uris|
      results = fetch(bucket: ['id:spotify', 'tracks'],
                            title: t[:title],
                            artist: t[:artist],
                            results: 20,
                            limit: true)
      en_song_with_tracks = any_tracks?(results) || next
      spotify_uris << spotify_uri_from_echonest_song(en_song_with_tracks)
    end
  end

  # {title: 'title', artist: 'artist'}
  def last_fm_tracks_to_hash(tracks)
    # cannot lookup from musicbrainz track id:
    # http://developer.echonest.com/forums/thread/816
    # Musicbrainz song IDs are not yet supported, only artist IDs.
    tracks.map do |lft|
      {title: lft.name, artist: lft.artist}
    end
  end

  def echonest_tracks_to_hash(tracks)
    tracks.map do |ent|
      {title: ent.title, artist: ent.artist_name}
    end
  end

  # returns 
  # [{"item_id": "creep",
  # "artist_name": "Radiohead",
  # "song_name": "Creep"},...]
  def taste_data_from_tracks_hash(tracks)
    tracks.map do |track|
      { action: 'update',
        item: { item_id:     "#{track[:title]}-#{track[:artist]}",
                artist_name: track[:artist],
                song_name:   track[:title] }
      }
    end
  end


  private

  def fetch(options)
    Rails.cache.fetch("fetch-track-#{options.to_json}", expires_in: 100.days) do
      @en.song_search(options)
    end
  end

  def any_tracks?(search_results)
    search_results.find { |en_song| !en_song.tracks.empty? }
  end

  def spotify_uri_from_echonest_song(en_song)
    en_song.tracks.first.foreign_id.split(':')[-1]
  end

  def tracks_hash
    tracks = [
      ["Unsung","Helmet ","Unsung: The Best Of Helmet 1991-1997"],
      ["Fuck Authority","Pennywise ","Land Of The Free?"], # they don't have this for some odd reason (it's in spotify)
      ["Time Marches On","Pennywise ","Land Of The Free?"],
      ["Paranoid","Black Sabbath ","Complete Studio Albums 1970-1978"],
      ["Jack The Stripper/Fairies Wear Boots","Black Sabbath ","Complete Studio Albums 1970-1978"],
      ["Closer","Nine Inch Nails ","The Downward Spiral"],
      ["The Hand That Feeds","Nine Inch Nails ","With Teeth"],
    ]
    tracks.each_with_object([]) {|t, arr| arr << {title: t[0], artist: t[1], album: t[2]} }
  end
end
