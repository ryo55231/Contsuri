class Admin::PostImagesController < ApplicationController
  before_action :authenticate_admin!
  def index
   @post_images = PostImage.all
  end

  def show
  @post_image = PostImage.find(params[:id])
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to admin_post_images_path
  end

  def edit
  end
    private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :image)
  end
end

