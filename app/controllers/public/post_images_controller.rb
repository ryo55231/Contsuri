class Public::PostImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
    redirect_to post_images_path, notice: "投稿に成功しました"
    else
    render :new
    end
  end

  def index
   if params[:latest]
     @post_images = PostImage.latest
   elsif params[:old]
     @post_images = PostImage.old
   elsif params[:favorite_count]
  # いいねをつけている投稿のみ取得し、いいねの数で並び替える
     @post_images_with_favorites = PostImage.joins(:favorites).group('post_images.id').order('count(favorites.id) desc')
  # いいねをつけていない投稿も取得する
     @post_images_without_favorites = PostImage.left_joins(:favorites).where(favorites: { id: nil }) 
  # いいねをつけている投稿といいねをつけていない投稿を結合して表示する
     @post_images = @post_images_with_favorites + @post_images_without_favorites
   else
     @post_images = PostImage.all
   end
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to "/post_images"
  end
  def edit
  end
    private
    def ensure_guest_user
    if current_user.guest_user?
      # ゲストユーザーの場合は投稿を制限する処理を追加する
      # 例えば、リダイレクトやエラーメッセージの表示など
      redirect_to new_post_image_path, alert:  "ゲストユーザーは投稿できません"
    end
   end

  def post_image_params
    params.require(:post_image).permit(:title, :body, :image)
  end
end
