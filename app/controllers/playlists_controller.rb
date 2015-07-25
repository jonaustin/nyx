class PlaylistsController < ApplicationController
  def playlist
    @spotify_uris = PlaylistService.new.hottt
  end
end
