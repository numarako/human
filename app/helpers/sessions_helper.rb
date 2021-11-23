module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
   # 現在のユーザーをログアウトする
   def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  #def current_user
  #  if (user_id = session[:user_id])
  #    @current_user ||= User.find_by(id: user_id)
  #  elsif (user_id = cookies.signed[:user_id])
  #    #raise # テストがパスすれば、この部分がテストされていないことがわかる
  #    user = User.find_by(id: user_id)
  #    #if user && user.authenticated?(cookies[:remember_token])
  #    if user && user.authenticated?(:remember, cookies[:remember_token])
  #      log_in user
  #      @current_user = user
  #    end
  # end 
  #end

   # ユーザーがログインしていればtrue、その他ならfalseを返す
   def logged_in?
    !current_user.nil?
  end

    # 記憶したURL（もしくはデフォルト値）にリダイレクト
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end
  
    # アクセスしようとしたURLを覚えておく
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end

    # URLのユーザIDと現在のユーザが一致しているか確認
    def correct_user
      @user = User.find_by(id: params[:id])
      @current_user = User.find_by(id: session[:user_id])
      if @user != @current_user
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
