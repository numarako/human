class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or root_path
    else
      flash.now[:danger] = 'メールアドレス、またはパスワードが違います'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
