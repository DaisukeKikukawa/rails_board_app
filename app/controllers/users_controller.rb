class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash[:danger] = t('.fail')
      render :new
    end
  end

  private

  def user_params
    # params.require(:user).permit(:first_name, :last_name, :email, :password)
    params.require(:user).permit(:email, :password, :password_confirmation, :last_name, :first_name)
  end

end
