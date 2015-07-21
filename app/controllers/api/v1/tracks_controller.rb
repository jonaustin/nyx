class Api::V1::TracksController < Api::BaseController
  before_action :set_track, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    @tracks = Track.all
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      respond_with @track, status: 201
    else
      respond_with @track.errors.full_messages
    end
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      respond_with @track
    else
      respond_with @track.errors.full_messages
    end
  end

  # DELETE /tracks/1
  def destroy
    name = @track.name
    @track.destroy
    respond_with "Track #{name} destroyed"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def track_params
      params.require(:track).permit(:name, :artist, :spotify_id, :order, :playlist_id)
    end
end
