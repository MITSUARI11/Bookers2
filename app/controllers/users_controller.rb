class UsersController < ApplicationController
  def index
    @user_id = current_user
    @users = User.all
    @newbook = Book.new
    @books = Book.all
  end
  
  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = "successfully submitted"
      redirect_to book_path(book.id)
    else
      flash.now[:aleat] = "submit error"
      redirect_to books_path(book.id)
    end
  end
  
  def show
    @user_id = User.find(params[:id])
    @newbook = Book.new
    @book = @user_id.books
    @book_id = Book.find(params[:id])
  end


  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to new_user_session_path
    end
    @user_id = current_user
  end
  
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "successfully updated"
      redirect_to user_path(user.id)
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
