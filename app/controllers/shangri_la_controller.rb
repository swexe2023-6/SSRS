class ShangriLaController < ApplicationController
  def index
    @users = User.all
  end
  
  def login
    
    user = User.find_by(email: params[:email])
    
    if user
      
      if BCrypt::Password.new(user.pass) == params[:pass]
        session[:login_uid]=params[:email]
        #session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:alert] = '※パスワードが間違ってるヨ！'
        redirect_to shangri_la_login_form_path
      end
    else
      flash[:alert] = '※メールアドレスが間違ってるヨ！'
      redirect_to shangri_la_login_form_path
    end
  end
  
  def logout
    session.delete(:login_uid)
    redirect_to root_path
  end
    
end
