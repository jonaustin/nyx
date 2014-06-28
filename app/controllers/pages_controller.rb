class PagesController < ApplicationController
  def home
    #@spotify_uris = Playlist.new.hottt
    @spotify_uris = Playlist.new.taste_playlist_from_tracks
  end
end
