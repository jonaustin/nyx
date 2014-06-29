class PagesController < ApplicationController
  def home
    redirect_to '/pages/hottt'
  end

  def hottt
    @spotify_uris = Playlist.new.hottt
    render :playlist
  end

  def playlist
    @spotify_uris = Playlist.new.spotify_playlist_from_tracks
    render :playlist
  end

  def top_tracks
    user = params[:user] || 'echowarpt'
    lastfm_tracks = Lastfm.new.top_weekly_tracks(user)
    playlist = Playlist.new
    tracks_hash = playlist.last_fm_tracks_to_hash(lastfm_tracks)
    @spotify_uris = playlist.spotify_playlist_from_tracks(tracks_hash)
    render :playlist
  end

  def taste_last_week
    # dry
    user = params[:user] || 'echowarpt'
    lastfm_tracks = Lastfm.new.top_weekly_tracks(user)
    playlist = Playlist.new
    tracks_hash = playlist.last_fm_tracks_to_hash(lastfm_tracks)
    taste_json = playlist.taste_data_from_tracks_hash(tracks_hash).to_json

    taste_profile = Echowrap.taste_profile_create(:name => 'Weekly Lastfm Top Tracks', :type => 'song')
    binding.pry 
    taste_id = taste_profile.id
    Rails.logger.info('TASTE ID: ' + taste_id)
    Echowrap.taste_profile_update(id: taste_id, data: taste_json)
    en_songs = Echowrap.playlist_basic(seed_catalog: taste_id, type: 'catalog-radio', results: 50)
    tracks_hash = playlist.echonest_tracks_to_hash(en_songs)
    @spotify_uris = playlist.spotify_playlist_from_tracks(tracks_hash)
    render :playlist
  end
end
