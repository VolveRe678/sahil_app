require 'rails_helper'

RSpec.feature "UsersEdits", type: :feature do
	let(:user){create(:user)}
  describe "edits" do
    it 'should edit users with proper information' do
			user
			login(user,user.password)
			visit edit_user_path(user)
			# debugger
			fill_in "user_name", with: "Sahil"
			fill_in "user_email", with: "s@z.com"
			fill_in "user_password", with: "1234567"
			fill_in "user_password_confirmation", with: "1234567"
			click_button 'Save changes'
			expect(page).to have_content 'Profile updated'
		end
		
		it 'should not edit users without proper information' do
		  user
			login(user,user.password)
			visit edit_user_path(user)
		  fill_in 'user_name', with: ''
			fill_in "user_email", with: 's@invalid'
			fill_in "user_password", with: "123"
			fill_in "user_password_confirmation", with: "456"
			click_button 'Save changes'
			expect(page).to have_content 'errors'
		end
  end
end
