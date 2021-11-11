require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", signup_path
    assert_match /検索/, response.body
    # ログイン時と分けてテストの必要あり
    # assert_select "a[href=?]", edit_user_path(current_user) 
  end
end
