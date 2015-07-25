class PlaylistsController < ApplicationController
  def playlist
    @spotify_uris = PlaylistService.new.hottt
  end

  def hottt
    @spotify_uris = PlaylistService.new.hottt
  end

  def top_tracks
    params[:user]   ||= default_user
    params[:start]  ||= 0 
    params[:limit]  ||= 90 
    params[:period] ||= '7day'
    lastfm_tracks = Lfm.new.top_tracks(echonest_params)
    playlist = PlaylistService.new
    tracks_hash = playlist.last_fm_tracks_to_hash(lastfm_tracks)
    @spotify_uris = playlist.spotify_playlist_from_tracks(tracks_hash)
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name, :user_id, :period, :start_date, :end_date)
  end

  def echonest_params
    params.permit(:user, :start, :limit, :period)
  end
end
