require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:sample)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              age: "under15",
                                              gender: "man",
                                              password:              "",
                                              password_confirmation: "" } }

    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    age = "under15"
    gender = "man"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              age: age,
                                              gender: gender,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to root_path
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
    assert_equal age,  @user.age
    assert_equal gender, @user.gender
  end

  test "age is filled in with nothing" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "Foo Bar",
                                              email: "foo@bar.com",
                                              age: "",
                                              gender: "man",
                                              password:              "",
                                              password_confirmation: "" } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end


  test "gender is filled in with nothing" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "Foo Bar",
                                              email: "foo@bar.com",
                                              age: "under15",
                                              gender: "",
                                              password:              "",
                                              password_confirmation: "" } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "translation from English to Japanese" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    assert_match /年齢を選択してください/, response.body
    assert_match /性別を選択してください/, response.body
  end
end
