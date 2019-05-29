require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    let!(:user) { create(:user) }

	let(:super_user) { create(:user, :super) }

	let(:not_active_user) { create(:user, :non_active) }
	# invalid params
	let(:valid_session) { { email: user.email, password: 'gaggag' } }
	let(:invalid_params) { { session: valid_session.merge(email: '') }	}
	let(:valid_params) { { session: valid_session }	}
    let(:not_active_params) { { session: valid_session.merge(email: not_active_user.email) } }
    
   describe "GET #new" do
    it 'should get login page' do
        get :new
        expect(response).to have_http_status(200)
    end
   end

   describe "POST #create" do
    context 'when credentials match and is activated' do
        it 'should redirect  to user page' do
            post :create, params:{session: valid_session}
            expect(response).to redirect_to(user)
        end
    end
    
    context 'when use is not activated' do
        it 'should redirect to root and show http status 302' do
            post :create, params: not_active_params
            expect(response).to have_http_status(302)
            expect(response).to redirect_to('/')
        end
    end

    context 'when credentials dont match' do
        it 'should render login page' do
            post :create,params:invalid_params
            expect(response).to have_http_status(200)
        end
    end
   end
end
