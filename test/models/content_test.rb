require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  def setup
    @content = Content.new(title: "仕事でのミス", journaling: "辛い", situation: 1, compassion: "みんな失敗するよ！")
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
