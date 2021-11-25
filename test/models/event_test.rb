require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:sample)
    @event = Event.create(user_id: @user.id, mind: 1, reason: "test", small_success: "test", small_thanks: "test", date: "2021-11-18")
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "user_id should be present" do
    @event.user_id = "     "
    assert_not @event.valid?
  end

  test "mind should be present" do
    @event.mind = "     "
    assert_not @event.valid?
  end

  test "reason should be present" do
    @event.reason = "     "
    assert_not @event.valid?
  end

  test "reason should not be too long" do
    @event.reason = "a" * 151
    assert_not @event.valid?
  end

  test "small_success should be present" do
    @event.small_success = "     "
    assert_not @event.valid?
  end

  test "small_success should not be too long" do
    @event.small_success = "a" * 151
    assert_not @event.valid?
  end

  test "small_thanks should be present" do
    @event.small_thanks = "     "
    assert_not @event.valid?
  end

  test "small_thanks should not be too long" do
    @event.small_thanks = "a" * 151
    assert_not @event.valid?
  end

  test "date should be present" do
    @event.date = "     "
    assert_not @event.valid?
  end
end
