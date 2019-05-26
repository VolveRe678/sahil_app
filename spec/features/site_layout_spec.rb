require 'rails_helper'

RSpec.feature "SiteLayouts", type: :feature do
  describe "layout links" do
    it 'should test for all layout links' do
			visit(root_path)
			expect(page).to have_content 'sample app'
			expect(page).to have_content 'Home'
      expect(page).to have_content 'Help'
      expect(page).to have_content 'Contact'
      expect(page).to have_content 'About'
    end
  end
end
