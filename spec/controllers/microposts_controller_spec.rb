require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
    let(:user) { create(:user, :super, name: "Sahil", email: "s@y.com", password:"123456", password_confirmation:"123456") }
    let(:other_user) { create(:user) }

    let(:micropost) { create(:micropost, user: user) }

    describe 'POST #create' do
        context 'not logged in user posts' do
            it 'should not create the post' do
                expect{post :create, params: {micropost:{content:"Lorem Ipsum"}}}.to change(Micropost, :count).by(0)
                expect(response).to redirect_to('/login')
            end
        end

        context 'logged in user posts' do
            it 'should create the post' do
                log_in(user)
                expect{post :create, params: {micropost:{content:"Lorem Ipsum"}}}.to change(Micropost, :count).by(1)
                expect(response).to redirect_to('/')
            end
        end
    end

    describe 'DELETE #destroy' do
        before(:all) do
            micropost = create(:micropost)

        end
        context 'non logged in user' do
            it 'should not change the number of micropost' do
                expect{delete :destroy, params: {user_id: user,id: user.to_param}}.to change(Micropost, :count).by(0)
                expect(response).to redirect_to('/login')
            end
        end 

        context 'logged in user destroys others micropost' do
            it 'should not let others destroy our micropost' do
                log_in(other_user)
                expect{delete :destroy, params: {user: user,id: user.to_param}}.to change(Micropost, :count).by(0)
                expect(response).to redirect_to('/')
            end
        end

        context 'logged in as admin' do

            it 'should delete the micropost' do
                login(user,user.password)
                # debugger
                micropost
								expect{
									delete :destroy, params: {id: micropost.id},
												 session: {user_id:user.id}
								}.to change(Micropost,:count).by(-1)
                # puts Micropost.count
                # delete :destroy, :id => user, :user => {micropost => user.id}
                # visit('/users')
                # expect{click_link('delete')}.to change(Micropost, :count).by(-1)
                # puts Micropost.count
                # expect(response).to have_http_status(302)
            end
        end
    end
end
