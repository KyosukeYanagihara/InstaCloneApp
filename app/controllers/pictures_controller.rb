class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  def index
    @pictures = Picture.all
  end

  def show
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def edit
    if @picture.user.id == current_user.id
      render :edit
    else
      redirect_to pictures_path, notice: "権限がありません"
    end
  end

  def create
    if params[:back]
      render :new
    else
      @picture = current_user.pictures.build(picture_params)
      if @picture.save
        PictureMailer.picture_mail(@picture).deliver
        redirect_to pictures_path, notice: "投稿しました"
      else
        render :new
      end
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to picture_path(@picture.id), notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    if @picture.user.id == current_user.id
      @picture.destroy
      redirect_to pictures_url, notice: "削除しました"
    else
      redirect_to pictures_path, notice: "権限がありません"
    end
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content, :user_id)
  end
end
