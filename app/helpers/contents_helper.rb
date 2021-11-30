module ContentsHelper
  def set_content
    @content = Content.find(params[:id])
  end

  def correct_content
    @content = current_user.contents.find_by(id: params[:id])
    if @content.nil?
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end

  # 投稿者と現在のユーザが同じならばtrue、その他ならばfalseを返す
  def poster?
    return true if @content.user_id == current_user.id
  end

  # 投稿の公開設定が"公開"ならばtrue、その他ならばfalseを返す
  def public_contents?
    return true if @content.status == "public" 
  end
end
