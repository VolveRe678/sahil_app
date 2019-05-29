require 'rails_helper'

RSpec.feature "UsersProfiles", type: :feature do
	let(:user) {create(:user)}
  describe "profile" do
    it 'should display profile' do
			# user
			visit user_path(user)
			expect(page).to have_content user.name
    end
  end
end
