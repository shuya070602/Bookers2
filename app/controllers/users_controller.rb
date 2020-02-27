class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  def show
      @users = User.find(params[:id])
      @book = Book.new
      @books = @users.books
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
     if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = 'Book was successfully updated.'
     else
      render :edit
     end

  end

  def index
      @users = User.all
      @book = Book.new
      @user = current_user
  end

 private
  def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
  end
   def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end
end
