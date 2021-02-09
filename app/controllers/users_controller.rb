class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  def new
    @user = User.new
    render layout: "no_header"
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render :new, layout: "no_header"
    end
  end

  def show
  end

  def edit
    if current_user.id == @user.id
      render :edit, layout: "no_header"
    else
      redirect_to pictures_path, notice: "権限がありません。"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集しました"
    else
      render :edit
    end
  end
    
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :image, :image_cache,
                                  :password_confirmation)
  end
end
