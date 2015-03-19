class TagsController < ApplicationController

  def create
    tag = Tag.create(tag_params)
    photo = Photo.find(tag.photo_id)
    redirect_to user_photo_path(photo.user, photo)
  end

  def destroy
    tag = Tag.find(params[:id])
    photo = Photo.find(tag.photo_id)
    tag.destroy
    redirect_to user_photo_path(photo.user, photo)
  end

  private
    def tag_params
      params.require(:tag).permit(:photo_id, :user_id)
    end

end
