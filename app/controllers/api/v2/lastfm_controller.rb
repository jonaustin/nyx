class Api::V2::LastfmController < Api::BaseController
  before_action :set_lastfm

  def user
    user = @lastfm.user(lastfm_params[:username])
    render json: user
  end

  private

  def set_lastfm
    @lastfm = Lfm.new
  end

  def lastfm_params
    params.permit(:username)
  end
end
