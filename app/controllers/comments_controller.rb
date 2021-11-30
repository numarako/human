class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      # コメント通知機能対応
      @content = @comment.content
      @content.create_notification_comment!(current_user, @comment.id)
      # コメント送信後は、一つ前のページへリダイレクトさせる。
      flash[:success] = "コメント投稿が完了しました！ ~あなたが幸せでありますように~"
      redirect_back(fallback_location: root_path)
    else
      # コメント送信後は、一つ前のページへリダイレクトさせる。
      flash[:danger] = "コメントが未選択です"
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:phrase, :content_id)
    end
end
