require 'rails_helper'

RSpec.feature 'select', :type => :feature do
  scenario 'jsが動作すること', js: true do
    user = User.create(name: 'test', email: '123456@gmail.com', age: 1, gender: 1, password: '123456', password_confirmation: '123456' )
    visit edit_user_path(user)
    #find("#user_age").find("option[value='1']").select_option
    expect(page).to have_field 'user_name', with: 'test'
    expect(page).to have_field 'user_email', with: '123456@gmail.com'
    expect(page).to have_field 'user_age', with: '1'
    expect(page).to have_field 'user_gender', with: '1'
    # HTML上でvalueタグが存在しないためテスト対象外
    #expect(page).to have_field 'user_password', with: ''
    #expect(page).to have_field 'user_password_confirmation', with: ''
  end

  scenario 'jsが無効化されている場合' do
    user = User.create(name: 'test', email: '123456@gmail.com', age: 1, gender: 1, password: '123456', password_confirmation: '123456' )
    visit edit_user_path(user)
    #find("#user_age").find("option[value='1']").select_option
    expect(page).to have_field 'user_name', with: 'test'
    expect(page).to have_field 'user_email', with: '123456@gmail.com'
    expect(page).to have_field 'user_age', with: ''
    expect(page).to have_field 'user_gender', with: ''
    # HTML上でvalueタグが存在しないためテスト対象外
    #expect(page).to have_field 'user_password', with: ''
    #expect(page).to have_field 'user_password_confirmation', with: ''
  end
end
