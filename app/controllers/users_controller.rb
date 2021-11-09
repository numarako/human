class UsersController < ApplicationController
  before_action :logged_in_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the App!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    gon.user_age = @user.age
    gon.user_gender = @user.gender
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :age, :gender, :password,
                                    :password_confirmation )
    end
end
