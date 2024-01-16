class ShangriLaController < ApplicationController
   require 'httpclient'
  
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
  
  def search
    # APIのURLと必要なパラメータを設定
    url = URI.parse("https://anime-api.deno.dev/anime/v1/master/#{params[:anime_year]}/#{params[:anime_cool]}")
    
    # URLにパラメータを追加
    
    # APIにリクエストを送信
    response = Net::HTTP.get_response(url)
    
    # レスポンスをJSONとしてパース
    @result = JSON.parse(response.body)
    
    # レスポンスを表示
    
    # puts "最初のidは#{result[i]['id']}\n" 

    
    render :index
  end

end
