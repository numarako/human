class ContentsController < ApplicationController
  before_action :translation_for_search, only: [:search]
  #before_action :set_content, only: %i[edit update destroy]

  def index
    @q = Content.ransack(params[:q])
    @contents = @q.result(distinct: true)
    render 'static_pages/home'
  end

  def search
    @q = Content.search(search_params)
    @contents = @q.result(distinct: true).page(params[:page])
  end

  def show
    @content = Content.find(params[:id])
  end

  def crate
  end

  def edit
  end

  def update
  end

  def destroy
  end


  # 検索用にage,genderのパラメータを変換
  def translation_for_search
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

  private
  def search_params
    params.require(:q).permit(:title_cont, :situation_cont, :user_age_eq, :user_gender_eq)
  end

  def set_content
    @content = current_user.contents.find(params[:id])
  end
end
