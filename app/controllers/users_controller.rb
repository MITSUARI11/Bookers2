class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to new_user_session_path
    end
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully updated"
      redirect_to user_path(@user.id)
    else
      flash.now[:aleat] = "update error"
      render :show
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
