class MemosController < ApplicationController
  before_action :logged_in_user
  before_action :set_memo, only: [:edit, :update, :destroy]
  before_action :correct_memo, only: [:edit, :update, :destroy]

  def index
    @memos = current_user.memos.page(params[:page])
  end

  def new
    @memo = Memo.new
  end

  def edit
  end

  def create
    @memo = current_user.memos.create(memo_params)
    if @memo.save
      flash[:success] = "自己メモを追加しました! ~あなたが幸せでありますように~"
      redirect_to memos_path
    else
      render 'new'
    end
  end

  def update
    if @memo.update(memo_params)
      flash[:success] = "自己メモを更新しました！ ~あなたが幸せでありますように~"
      redirect_to memos_path
    else
      render 'edit'
    end
  end

  def destroy
    @memo.destroy
    flash[:success] = "自己メモを削除しました！"
    redirect_to memos_path
  end
  
  private
    def memo_params
      params.require(:memo).permit(:category, :title, :text)
    end

    # 更新系アクションで利用するインスタンスを生成
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # 更新系アクションの対象が正しいか確認
    def correct_memo
      @memo = current_user.memos.find_by(id: params[:id])
      if @memo.nil?
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
