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

  test "title should not be too long" do
    @content.title = "a" * 51
    assert_not @content.valid?
  end

  test "emotions should be present" do
    @content.emotions = "     "
    assert_not @content.valid?
  end

  test "score should be present" do
    @content.score = "     "
    assert_not @content.valid?
  end

  test "score should be 1 to 100" do
    @content.score = 0
    assert_not @content.valid?

    @content.score = 1
    assert @content.valid?

    @content.score = 100
    assert @content.valid?
    
    @content.score = 101
    assert_not @content.valid?
  end

  test "journaling should be present" do
    @content.journaling = "     "
    assert_not @content.valid?
  end

  test "journaling should not be too long" do
    @content.journaling = "a" * 651
    assert_not @content.valid?
  end

  test "situation should be present" do
    @content.situation = "     "
    assert_not @content.valid?
  end

  test "situation should not be too long" do
    @content.situation = "a" * 651
    assert_not @content.valid?
  end

  test "compassion should be present" do
    @content.compassion = "     "
    assert_not @content.valid?
  end

  test "compassion should not be too long" do
    @content.compassion = "a" * 651
    assert_not @content.valid?
  end
end
