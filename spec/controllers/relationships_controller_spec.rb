require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
	let(:follower) {create(:user)}
	let(:followed) {create(:user)}
	let(:relationship) { create(:relationship, follower: follower, followed:
			followed) }
	let(:followed_id) {{followed_id: followed.id}}
	let(:follower_id) {{follower_id: follower.id}}
	let(:follower_session) {{user_id: follower.id}}
	
	describe 'POST #create' do
		context 'when user follows another user withou ajax' do
			it "should increse relationships" do
				expect {
					post :create, params: followed_id, session: follower_session
				}.to change(Relationship, :count).by(1)
			end
			
			it "should redirect to follower user" do
			 post :create, params: followed_id, session: follower_session
				expect(response).to redirect_to(followed)
			end
		end
		
		context 'when user follows another user with ajax' do
			it "should increse relationships" do
			expect{
				post :create, xhr: true, params: followed_id, session: follower_session
			}.to change(Relationship, :count).by(1)
			end
			
			it "should send a success 200 response" do
				post :create, xhr: true, params: followed_id, session: follower_session
				expect(response).to have_http_status(200)
			end
		end
	end
	
	describe "DELETE #destroy" do
		context 'when user unfollows another user without ajax' do
			it 'should decrease relationships' do
				relationship
				expect{
					delete :destroy, params: {id: relationship.id}, session:
							follower_session
				}.to change(Relationship, :count).by(-1)
			end
			
			it 'should redirect to the unfollowed user' do
				delete :destroy, params: {id: relationship.id}, session: follower_session
				expect(response).to redirect_to(followed)
			end
		end
		
		context 'when user unfollows another user with ajax' do
			it 'should decrease relationships' do
				relationship
				expect{
					delete :destroy, xhr: true, params: {id: relationship.id}, session:
							follower_session
				}.to change(Relationship, :count).by(-1)
			end
			
			it 'should send a success 200 response' do
				delete :destroy, xhr: true, params: {id: relationship.id}, session:
						follower_session
				expect(response).to have_http_status(200)
			end
		end
	end
end
