require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
	describe "POST #edit" do
		let(:active_user) {create(:user)}
		let(:non_active_user) {create(:user, :non_active)}
		let(:invalid_params)do
			{email: active_user.email, id: ''}
		end
		
		context 'when user params are wrong' do
			it 'should redirect to root url' do
				get :edit, params: invalid_params
				expect(response).to redirect_to(root_url)
			end
		end
		
		context 'when user params are correct' do
			it 'should activate the user and redirect to the user page' do
				get :edit, {params: {
				email: non_active_user.email,
				id: non_active_user.activation_token
				}}
				expect(response).to redirect_to(non_active_user)
				expect(non_active_user.reload).to be_activated
			end
		end
		end
	end

