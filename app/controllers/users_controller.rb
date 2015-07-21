class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user

  def profile
  end

  def update
    if @user.update(user_params)
      redirect_to profile_user_path, notice: 'Profile was successfully updated.'
    else
      render :profile
    end
  end

  def update_password
    if @user.update(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path, notice: 'Password was successfully updated.'
    else
      render :profile
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation, :lastfm_username)
    end
end

