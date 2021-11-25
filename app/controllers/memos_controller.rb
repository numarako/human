class MemosController < ApplicationController
  before_action :set_memo, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:index]
  before_action :logged_in_user, only: [:create] # actionの中でcorrect_userを指定
  before_action :correct_memo, only: [:edit, :update, :destroy]

  def index
    @memos = Memo.where(user_id: params[:id]).page(params[:page])
  end

  def new
    @memo = Memo.new
  end

  def edit
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      flash[:success] = "自己メモを追加しました!"
      redirect_to index_memos_path(current_user)
    else
      render 'new'
    end
  end

  def update
    if @memo.update(memo_params)
      flash[:success] = "自己メモを更新しました！"
      redirect_to index_memos_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @memo.destroy
    flash[:success] = "自己メモを削除しました！"
    redirect_to index_memos_path(current_user)
  end
  
  private
    def memo_params
      params.require(:memo).permit(:category, :title, :text)
    end

    def set_memo
      @memo = Memo.find(params[:id])
    end

    def correct_memo
      @memo = current_user.memos.find_by(id: params[:id])
      if @memo.nil?
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
