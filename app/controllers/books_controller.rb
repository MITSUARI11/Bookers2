class BooksController < ApplicationController
  
  def index
    @user_id = current_user
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
      render :index
    end
  end

  def show
    @book = Book.find(params[:id]) 
    @newbook = Book.new
    @user_id = user.find(params[:id])
    @user = @book.user
  end

  def edit
    is_matching_login_user
    @books = Book.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @books = Book.find(params[:id])
    if @books.update(books_params)
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
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to new_user_session_path
    end
  end
  
  
end
