class Admin::UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.all
  end

  def edit
  end
  
  def update
    user = User.find(params[:id])
    if user.update!(user_params)
      redirect_to admin_user_path(user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
