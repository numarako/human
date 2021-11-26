class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index_contents, :index_bookmarks]
  before_action :correct_user,   only: [:edit, :update, :index_contents, :index_bookmarks]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそ!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました！"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def index_contents
    @user = User.find(params[:id])
    @contents = @user.contents.order(updated_at: "DESC").page(params[:page])
  end

  def index_bookmarks
    @user = User.find(params[:id])
    @content_bookmatrks = @user.content_bookmarks
    bookmarks_array = @content_bookmatrks.map{|content_bookmark| content_bookmark.content }.sort! {|x, y| y["updated_at"] <=> x["updated_at"] }
    @contents =  Kaminari.paginate_array(bookmarks_array).page(params[:page])
  end 
  
  private 
    def user_params
      params.require(:user).permit(:name, :email, :age, :gender, :situation, :password, :password_confirmation )
    end
end
