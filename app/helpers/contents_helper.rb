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
end
