require 'test_helper'

class MemoTest < ActiveSupport::TestCase
  def setup
    @user = users(:sample)
    @memo = @user.memos.build(title: "tetst", category: 1, text: "test")
  end

  test "should be valid" do
    assert @memo.valid?
  end

  test "title should be present" do
    @memo.title = "     "
    assert_not @memo.valid?
  end

  test "title should not be too long" do
    @memo.title = "a" * 51
    assert_not @memo.valid?
  end

  test "category should be present" do
    @memo.category = "     "
    assert_not @memo.valid?
  end

  test "text should be present" do
    @memo.text = "     "
    assert_not @memo.valid?
  end

  test "text should not be too long" do
    @memo.text = "a" * 501
    assert_not @memo.valid?
  end 
end
