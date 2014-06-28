class PagesController < ApplicationController
  def home
    @spotify_uris = Playlist.new.hottt
  end

  def playlist
    @spotify_uris = Playlist.new.taste_playlist_from_tracks
    render :home
  end

end
