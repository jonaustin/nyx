class PagesController < ApplicationController
  def home
    @spotify_uris = Playlist.new.hottt
  end

  def playlist
    @spotify_uris = Playlist.new.spotify_playlist_from_tracks
    render :home
  end

  def top_tracks
    user = params[:user] || 'echowarpt'
    lastfm_tracks = Lastfm.new.top_weekly_tracks(user)
    playlist = Playlist.new
    track_hash = playlist.last_fm_tracks_to_hash(lastfm_tracks)
    @spotify_uris = playlist.spotify_playlist_from_tracks(track_hash)
    render :home
  end
end
