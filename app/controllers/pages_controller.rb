class PagesController < ApplicationController
  def home
    @spotify_uris = Playlist.new.hottt
  end
end
