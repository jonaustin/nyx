class PagesController < ApplicationController
  def home
    redirect_to playlist_path
  end

  def taste_last_week
    # dry
    user = params[:user] || current_user.lastfm_username
    lastfm_tracks = Lastfm.new.top_weekly_tracks(user)
    playlist = PlaylistService.new
    tracks_hash = playlist.last_fm_tracks_to_hash(lastfm_tracks)
    taste_json = playlist.taste_data_from_tracks_hash(tracks_hash).to_json

    taste_profile = Echowrap.taste_profile_create(:name => 'Weekly Lastfm Top Tracks', :type => 'song')
    taste_id = taste_profile.id
    Rails.logger.info('TASTE ID: ' + taste_id)
    Echowrap.taste_profile_update(id: taste_id, data: taste_json)
    en_songs = Echowrap.playlist_static(seed_catalog: taste_id, type: 'catalog-radio', results: 50)
    tracks_hash = playlist.echonest_tracks_to_hash(en_songs)
    @spotify_uris = playlist.spotify_playlist_from_tracks(tracks_hash)
    render :playlist
  end

  def echonest_params
    params.permit(:user, :start, :limit, :period)
  end
end
