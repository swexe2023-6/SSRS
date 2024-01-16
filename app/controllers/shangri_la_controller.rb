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
    all_results = JSON.parse(response.body)
    #@result = JSON.parse(response.body)

    # キーワードに合致するもののみを抽出
    if params[:keyword] == ""
      @result = all_results
    else
      @result = all_results.select { |item| params[:keyword].present? && item['title'].include?(params[:keyword]) }
    end
    
    # レスポンスを表示
    render :index
  end
  
  def info
    item_json = params[:item]
    puts 'infoアクションに接続'
    @info = JSON.parse(item_json)
    render :info_page
  end

end
