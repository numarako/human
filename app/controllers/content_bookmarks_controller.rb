class ContentBookmarksController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_content
  before_action :set_content

  # お気に入り登録
  def create
    if @content.user_id != current_user.id   # 投稿者本人以外に限定
      @content_bookmatrk = ContentBookmark.create(user_id: current_user.id, content_id: @content.id)
    end
  end

  # お気に入り削除
  def destroy
    @content_bookmatrk = ContentBookmark.find_by(user_id: current_user.id, content_id: @content.id)
    @content_bookmatrk.destroy
  end
end
