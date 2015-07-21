class Api::PlaylistsController < Api::BaseController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  respond_to :json, except: [:playlist, :template]
  respond_to :html, only:   [:playlist, :template]

  def index
    respond_with current_user.playlists
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.save
      respond_with @playlist, status: 201
    else
      respond_with @playlist.errors.full_messages
    end
  end

  def update
    if @playlist.update(playlist_params)
      respond_with @playlist
    else
      respond_with @playlist.errors.full_messages
    end
  end

  def destroy
    name = @playlist.name
    @playlist.destroy
    respond_with "Playlist #{name} destroyed", status: :success
  end

  def hottt
    respond_with PlaylistService.new.hottt
  end

  def top_tracks
    params[:user]   ||= default_user
    params[:start]  ||= 0 
    params[:limit]  ||= 90 
    params[:period] ||= '7day'
    lastfm_tracks = Lfm.new.top_tracks(echonest_params)
    playlist = PlaylistService.new
    tracks_hash = playlist.last_fm_tracks_to_hash(lastfm_tracks)
    spotify_uris = playlist.spotify_playlist_from_tracks(tracks_hash)
    respond_with spotify_uris

  end

  # $routeProvider.when '/something', templateUrl: '/api/playlists/something.html', controller: 'SomethingController'
  def template
    render :template => 'api/playlists/' + params[:path], :layout => nil
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def playlist_params
      params.require(:playlist).permit(:name, :user_id, :period, :start_date, :end_date)
    end

    def echonest_params
      params.permit(:user, :start, :limit, :period)
    end

    def default_user
      current_user ? current_user.lastfm_username : 'echowarpt'
    end
end
