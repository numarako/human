class ContentBookmarksController < ApplicationController
  before_action :logged_in_user
  before_action :set_content, only: [:create, :destroy]

   def index
    @content_bookmatrks = current_user.content_bookmarks.includes([:content])
    bookmarks_array = @content_bookmatrks.map{|content_bookmark| content_bookmark.content }.sort! {|x, y| y["updated_at"] <=> x["updated_at"] }
    @contents =  Kaminari.paginate_array(bookmarks_array).page(params[:page])
  end 

  # お気に入り登録
  def create
    if !poster?  # 投稿者本人以外に限定
      @content_bookmatrk = ContentBookmark.create(user_id: current_user.id, content_id: @content.id)
      respond_to do |format|
        format.html { redirect_to user }
        format.js
      end
    end
  end

  # お気に入り削除
  def destroy
    @content_bookmatrk = ContentBookmark.find_by(user_id: current_user.id, content_id: @content.id)
    @content_bookmatrk.destroy
    respond_to do |format|
      format.html { redirect_to user }
      format.js
    end
  end
end
