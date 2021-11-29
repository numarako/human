require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:sample)
    @content = contents(:sample)
    @comment = Comment.create(user_id: @user.id, content_id: @content.id, phrase: 1, created_at: Time.zone.now, updated_at: Time.zone.now)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user_id should be present" do
    @comment.user_id = "     "
    assert_not @comment.valid?
  end

  test "content_id should be present" do
    @comment.content_id = "     "
    assert_not @comment.valid?
  end

  test "phrase should be present" do
    @comment.phrase = "     "
    assert_not @comment.valid?
  end
end
