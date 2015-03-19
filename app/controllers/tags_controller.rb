class TagsController < ApplicationController

  def create
    params[:tag][:user_id].each do |user_id|
      unless user_id.blank?
        tag = Tag.new(tag_params)
        tag.user_id = user_id
        tag.save
      end
    end
    photo = Photo.find(params[:tag][:photo_id])
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
      params.require(:tag).permit(:photo_id)
    end

end
