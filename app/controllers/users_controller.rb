class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def new
    @users = User.all
  end
  
  def create
    if User.exists?(email: params[:email])
      flash[:alert] = '※そのユーザIDは使えんでぇ～'
      redirect_to new_user_path
    else
      #hashed_password = BCrypt::Password.create(params[:pass])
      user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      if user.save
        redirect_to root_path
      else
        render 'new'
      end
    end
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end
end