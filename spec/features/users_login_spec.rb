require 'rails_helper'

RSpec.feature "UsersLogins", type: :feature do
	let(:user){create(:user)}
  describe "login" do
    it 'should not login with invalid information' do
			visit login_path
      within('form') do
        fill_in "session_email", with: ''
        fill_in "session_password", with: ''
      end
			click_button 'Log in'
			expect(page).to have_content 'Invalid email/password combination'
		end

    it 'should login with valid information' do
			user
			# login(user,user.password)
			visit login_path
			within('form') do
			  fill_in "session_email", with: user.email
				fill_in "session_password", with: user.password
			end
			click_button 'Log in'
			expect(page).to have_content user.name
			end
		end
	
  end

