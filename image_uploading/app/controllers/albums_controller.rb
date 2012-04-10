# encoding: utf-8
class AlbumsController < ApplicationController
  before_filter :find_album, :only => %w(show edit update destroy)
  respond_to :html

  def index
    @albums = Album.scoped
  end

  def show
    respond_with(@album)
  end

  def new
    @album = Album.new
    5.times { @album.photos.build.build_image }
  end

  def edit
    respond_with(@album)
  end

  def create
    @album = Album.new(params[:album])
    
    if @album.save
      flash[:notice] = "Страница успешно создана."
    else
      flash[:alert] = "При создании страницы произошли ошибки."
    end

    respond_with(@album)
  end

  def update
    if @album.update_attributes(params[:album])
      flash[:notice] = "Все изменения сохранены."
    else
      flash[:alert] = "При сохранении страницы произошли ошибки."
    end

    respond_with(@album)
  end

  def destroy
    @album.destroy
    respond_with(@album)
  end

private

  def find_album
    @album = Album.find(params[:id])
  end

end
