class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @user_id = current_user
    @newbook = Book.new
    @books = Book.all
  end
  
  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    @user_id = current_user
    @books = Book.all
    if @newbook.save
      flash[:notice] = "successfully submitted"
      redirect_to book_path(@newbook.id)
    else
      flash.now[:aleat] = "submit error"
      render :index
    end
  end

  def show
    @book = Book.find(params[:id]) 
    @newbook = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully updated"
      redirect_to book_path(@book.id)
    else
      flash.now[:alate] = "update error"
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to users_path
    end
  end
  
  
end
