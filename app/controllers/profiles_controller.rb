class ProfilesController < ApplicationController
  before_action :set_user
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'ユーザーを更新しました'
    else
      flash.now[:danger] = "ユーザーを更新できませんでした"
      render :edit
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar, :avatar_cache)
  end

end
