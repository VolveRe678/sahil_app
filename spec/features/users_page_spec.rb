require 'rails_helper'

RSpec.feature "Followings", type: :feature do
  let(:sahil){create(:user,name:"Sahil Maharjan",email:"sahil.maharja@yahoo.com",password:"hahaha", password_confirmation:"hahaha")}
  let(:rohan){create(:user,name:"Rohan Maharjan",email:"rohan.maharjan@yahoo.com",password:"hahaha", password_confirmation:"hahaha")}
	let(:micropost) {create(:micropost,user: sahil)}
	
  describe 'the users page' do
    context 'when not logged' do
      it 'should check users page' do
				visit user_path(sahil.id)
				# debugger
				expect(page).to have_content sahil.name
				expect(page).to have_content(sahil.followers.count)
				expect(page).to have_content(sahil.following.count)
			end
		end
		context 'posts are present' do
      it 'should see the micropost' do
				micropost
				visit user_path(sahil)
				expect(page).to have_content'Micropost'
				expect(page).to have_content(micropost.content)
      end
		end
	context 'when logged in' do
		before do
			login(rohan,rohan.password)
			visit user_path(sahil)
		end
		
		it 'should see follow or unfollow button' do
			page.should have_selector(:link_or_button, 'Follow')
		end
		
		context 'when visitor follows user' do
			it 'should change from follow to unfollow' do
				click_button 'Follow'
				page.should have_selector(:link_or_button, 'Unfollow')
			end
		end
		
		context 'when visitor unfollows user' do
			it 'should change from unfollow to follow' do
				click_button 'Follow'
				click_button 'Unfollow'
				page.should have_selector(:link_or_button, 'Follow')
			end
		end
		
	end
	end
	
end
