class Admin::PostImagesController < ApplicationController
  def index
   @post_images = PostImage.all
  end

  def show
  end

  def edit
  end
    private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :image)
  end
end

