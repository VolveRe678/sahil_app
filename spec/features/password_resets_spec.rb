require 'rails_helper'

RSpec.feature "PasswordResets", type: :feature do
  describe 'password' do
    	let(:user) {create(:user)}
		it 'should reset the password when email matches' do
			user
			visit(new_password_reset_path)
			fill_in "password_reset_email", with: user.email
			click_button 'Submit'
			expect(page).to have_content 'Email sent with password reset instructions'
			# debugger
			# visit
		end
    it 'should check for expired token' do
			# user
			visit(new_password_reset_path)
			fill_in 'password_reset_email', with: 'sahil@maharjan.com'
			click_button 'Submit'
			expect(page).to have_content 'Email address not found'
    end
  end
end
