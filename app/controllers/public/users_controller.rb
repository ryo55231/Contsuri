class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice: 'ユーザー情報を保存しました。'
    else
       @users = User.all
    render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.is_active = false
      if @user.save
      reset_session
      flash[:notice] = "退会処理を実行しました"
      redirect_to root_path
      end
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @favorite_posts = PostImage.find(favorites)
  end

    private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
