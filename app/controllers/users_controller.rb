class UsersController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end
  
  def create
    book = Book.new(book_params)
    book.save
    redirect_to edit_book_path(current_user)
  end

  def show
    
  end

  def edit
    @user = current.user
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
