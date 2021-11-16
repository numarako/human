require 'test_helper'

class ContentBookmarkTest < ActiveSupport::TestCase
  def setup
    @user = users(:sample)
    @content = contents(:sample)
    @content_bookmark = ContentBookmark.create(user_id: @user.id, content_id: @content.id, created_at: Time.zone.now, updated_at: Time.zone.now)
  end

  test "should be valid" do
    assert @content_bookmark.valid?
  end

  test "user_id should be present" do
    @content_bookmark.user_id = "     "
    assert_not @content_bookmark.valid?
  end

  test "content_id should be present" do
    @content_bookmark.content_id = "     "
    assert_not @content_bookmark.valid?
  end
end
