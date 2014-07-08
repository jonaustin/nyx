class Api::PlaylistsController < Api::BaseController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  respond_to :json

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

  # $routeProvider.when '/something', templateUrl: '/playlists/something.html', controller: 'SomethingController'
  def template
    render :template => 'playlists/' + params[:path], :layout => nil
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def playlist_params
      params.require(:playlist).permit(:name, :user_id)
    end
end
