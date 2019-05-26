require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    before(:all) do
        # user2 = create(:user, username: "Bob", email: "bob@gmail.com")
        @user = create(:user, :super, name: "Sahil",email: "sahil.maharjan@yahoo.com", password: "123456", password_confirmation: "123456")
        @another_user = create(:user)
    end

    let(:valid_user)  {{name:"Sahil",email:"sahil@valid.com", password: "123456", password_confirmation:"123456"}} 
    let(:invalid_user) {{name:"",email:"sahil@invalid", password: "123", password_confirmation:"456"}}
    describe 'GET #index' do
        it 'should redirect index to login when not logged in' do
            get :index
            expect(response).to redirect_to('/login')
        end

        it 'should redirect index to home when logged in' do
        log_in(@user)
        get :index, params:{id: @user.to_param} 
        expect(response).to have_http_status(200)
        end
        
    end

    describe 'GET #show' do
        it 'should should get show' do
            get :show, params:{id: @user.to_param}
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET #create' do
        context 'with valid params' do
            it 'should create a user on signup' do
                expect{post :create, params:{user: valid_user}}.to change(User,:count).by(1)
            end

            it 'should redirect to root path' do
                post :create, params:{user: valid_user}
                expect(response).to redirect_to('/')
            end

        end

        context 'with invalid params' do
            it 'should redirect to signup page' do
                expect{post :create, params:{user: invalid_user}}.to change(User,:count).by(0)
            end
        end
    end

    describe 'GET #edit' do
        it 'should redirect edit when not logged in' do
            get :edit, params: {id: @user.to_param}
            expect(response).to redirect_to('/login')
        end

        it 'should redirect edit when logged in as wrong user' do
            log_in(@another_user)
            # get edit_user_path(@user)
            get :edit, params: {id:@user.to_param}
            expect(response).to redirect_to('/')            
        end
    end

    describe 'PATCH #update' do
        it 'should redirect update when not logged in' do
            patch :update, params: {id: @user.to_param}
            expect(response).to redirect_to('/login')
        end

        it 'should redirect update when logged in as wrong user' do 
            log_in(@another_user)
            patch :update, params: {id: @user.to_param}
            expect(response).to redirect_to('/')
        end

        it 'should not allow the admin attribute to be edited via web' do
            login(@another_user,@another_user.password)
            expect(@another_user.admin?).to be false
            patch :update, params: {id:@another_user.to_param ,user: {
                password: "",
                password_confirmation: "",
                admin: true
            }}
            expect(@another_user.reload.admin?).to be false
        end
    end

    describe "DELETE #destroy" do
        it 'should redirect destroy when not logged in' do
            delete :destroy, params: {id:@user.to_param}
            expect(response).to redirect_to('/login')
        end

        it 'should redirect destroy when logged in as non admin' do
            log_in(@another_user)
            expect(@another_user.admin?).to be false
            delete :destroy, params: {id:@user.to_param}
            expect(response).to redirect_to('/')
        end
    end
end
