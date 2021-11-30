class ContentsController < ApplicationController
  before_action :logged_in_user, except: [:search_index, :search, :show]
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :correct_content, only: [:edit, :update, :destroy]
  before_action :check_params_for_search, only: [:search]
  before_action :check_release_status, only: [:show]

  # トップ画面
  def search_index
    @q = Content.ransack(params[:q])
    @contents = @q.result.includes(:user)
    render 'static_pages/home'
  end

  def search
    @q = Content.search(search_params)
    @contents = @q.result.includes(:user).page(params[:page])
  end

  def show
    @comments = @content.comments # 投稿詳細に関連付けてあるコメントを全取得
    @comment = Comment.new # 投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
  end

   # 過去投稿画面
   def index
    @contents = current_user.contents.page(params[:page])
  end

  def new
    @content = Content.new
  end

  def create
    @content = current_user.contents.build(content_params)
    if @content.save
      flash[:success] = "新規投稿が完了しました! ~あなたが幸せでありますように~"
      redirect_to contents_path
    else
      render 'new'  
    end
  end

  def edit
  end

  def update
    if @content.update(content_params)
      flash[:success] = "投稿を更新しました！ ~あなたが幸せでありますように~"
      redirect_to contents_path
    else
      render 'edit'
    end
  end

  def destroy
    @content.destroy
    flash[:success] = "投稿を削除しました！"
    redirect_to contents_path
  end

  private
    def search_params
      params.require(:q).permit(:title_cont, :situation_cont, :user_age_eq, :user_gender_eq).merge(status_eq: 1)
    end

    def content_params
      params.require(:content).permit(:title, :emotions, :score, :journaling, :situation, :compassion, :status)
    end

    # 投稿の公開設定を確認
    def check_release_status
      if !public_contents? # 非公開設定に限定
        if logged_in? && poster?
          # 投稿者本人の場合は閲覧可能
        else
          flash[:danger] = "非公開投稿のため閲覧不可"
              redirect_to root_path
        end
      end
    end

    # age,genderのパラメータを検索用に変換
    def check_params_for_search
    case params[:q][:user_age_eq]
    when "default_age" then
      params[:q][:user_age_eq] = ""
    when "under15" then
      params[:q][:user_age_eq] = 0
    when "late_teens" then
      params[:q][:user_age_eq] = 1
    when "twenties" then
      params[:q][:user_age_eq] = 2
    when "thirties" then
      params[:q][:user_age_eq] = 3
    when "forties" then
      params[:q][:user_age_eq] = 4
    when "fifties" then
      params[:q][:user_age_eq] = 5
    when "sixties" then
      params[:q][:user_age_eq] = 6
    when "over70" then
      params[:q][:user_age_eq] = 7
    when "no_age" then
      params[:q][:user_age_eq] = 8
    end

    case params[:q][:user_gender_eq]
    when "default_gender" then
      params[:q][:user_gender_eq] = ""
    when "man" then
      params[:q][:user_gender_eq] = 0
    when "woman" then
      params[:q][:user_gender_eq] = 1
    when "other" then
      params[:q][:user_gender_eq] = 2
    when "no_gender" then
      params[:q][:user_gender_eq] = 3
    end
    end
end
