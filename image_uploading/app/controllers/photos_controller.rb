# encoding: utf-8
class PhotosController < ApplicationController
  before_filter :find_album
  before_filter :find_photo, :only => :show
  respond_to :html

  def show
    respond_with(@photo)
  end

private

  def find_album
    @album = Album.find(params[:album_id])
  end

  def find_photo
    @photo = @album.photos.find(params[:id])
  end

end
