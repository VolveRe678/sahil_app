require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  describe "invalid signup" do
    it 'should not signup user without valid info' do
			visit('/signup')
			fill_in "user_name", with: ''
			fill_in "user_email", with: 'user@invalid'
			fill_in "user_password", with:'123'
			fill_in "user_password_confirmation", with: '456'
			click_button 'Create my account'
			expect(page).to have_content `Name can't be blank`
			expect(page).to have_content 'Email is invalid'
			expect(page).to have_content 'Password is too short'
			expect(page).to have_content `Password confirmation doesn't match
Password`
    end
	end

  describe "valid signup" do
    it 'should signup user with valid info' do
			visit('/signup')
      fill_in "user_name", with: 'valid'
      fill_in "user_email", with: 'user@valid.com'
      fill_in "user_password", with:'123456'
      fill_in "user_password_confirmation", with: '123456'
			click_button 'Create my account'
			expect(page).to have_content 'Please check your email to activate your account'
    end
  end
end
