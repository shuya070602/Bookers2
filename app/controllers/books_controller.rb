class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit]
  before_action :correct_user, only: [:edit, :update]
  def index
      @books = Book.all
      @book = Book.new
      @user = current_user
  end

  def show
      @books = Book.find(params[:id])
      @book = Book.new
      @user = @books.user
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
     if @book.save
        redirect_to book_path(@book.id)
        flash[:notice] = 'Book was successfully created.'
     else
     	@user = current_user
        @books = Book.all
        render :index
     end
  end

  def new
      @book = Book.new
  end

  def edit
      @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
     if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = 'Book was successfully updated.'
     else
      render :edit
     end
  end

  def destroy
      @books = Book.find(params[:id])
      @books.destroy
      redirect_to books_path
  end

 private
  def book_params
      params.require(:book).permit(:title, :body)
  end
  def correct_user
    book = Book.find(params[:id])
    if current_user != book.user
      redirect_to books_path
    end
  end
end
