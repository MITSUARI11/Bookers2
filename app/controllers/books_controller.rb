class BooksController < ApplicationController
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end
  
  def create
    book = Book.new(book_params)
    if book.save
      flash[:notice] = "successfully submitted"
      redirect_to edit_book_path(current_user)
    else
      flash.now[:aleat] = "submit error"
      render :index
    end
  end

  def show
  end

  def edit
    @user = current_user
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to books_path(book.id)
  end
  
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
