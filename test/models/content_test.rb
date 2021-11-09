require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  def setup
    @user = users(:sample)
    @content = @user.contents.build(title: "仕事でのミス", emotions: 1, score: 100,
                            journaling: "辛い", situation: 1, compassion: "みんな失敗するよ！", release: 0)
  end

  test "should be valid" do
    assert @content.valid?
  end

  test "title should be present" do
    @content.title = "     "
    assert_not @content.valid?
  end

  test "journaling should be present" do
    @content.journaling = "     "
    assert_not @content.valid?
  end

  test "situation should be present" do
    @content.situation = "     "
    assert_not @content.valid?
  end

  test "compassion should be present" do
    @content.compassion = "     "
    assert_not @content.valid?
  end
end
