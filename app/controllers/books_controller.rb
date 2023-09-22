class BooksController < ApplicationController
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end
  
  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = "successfully submitted"
      redirect_to book_path(book.id)
    else
      flash.now[:aleat] = "submit error"
      render :index
    end
  end

  def show
    @book = Book.find(params[:id]) 
    @user = @book.user
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to new_user_session_path
    end
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Successfully updated"
      redirect_to books_path
    else
      flash.now[:alate] = "update error"
      render :now
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
  
end
