require 'rails_helper'

RSpec.describe "Users", type: :request do
	let(:user) { create(:user) }
	let(:other_user) { create(:user) }
	let(:super_user) { create(:user, :super) }
	let(:super_user2) { create(:user, :super) }
	let(:valid_params) { build(:user).attributes.merge(password: 'gaggag') }
	let(:invalid_params) { valid_params.merge(password: '') }
	
	describe "GET /users" do
		context "when user is not logged in" do
			it "should redirect to login page" do
				get users_path
				expect(response).to have_http_status(302)
			end
		end
		
		context "when user is logged in" do
			it "should return success response" do
				login(user,user.password)
				get users_path
				expect(response).to have_http_status(302)
			end
		end
	end
	
	describe "POST /users" do
		context "when invalid attributes" do
			it "should return failure response" do
				post users_path, params: { user: invalid_params }
				expect(response).to have_http_status(200)
				expect(response).to render_template('users/new')
			end
		end
		
		context "when valid attributes" do
			it "should redirect to user page" do
				post users_path, params: { user: valid_params }
				expect(response).to have_http_status(302)
			end
		end
	end
	
	describe "GET /users/new" do
		it "should return success response" do
			get new_user_path
			expect(response).to have_http_status(200)
		end
	end
	
	describe "GET /signup" do
		it "should return success response" do
			get signup_path
			expect(response).to have_http_status(200)
		end
	end
	
	describe "POST /signup" do
		context "when invalid attributes" do
			it "should return failure response" do
				post '/signup', params: { user: invalid_params }
				expect(response).to have_http_status(200)
				expect(response).to render_template('users/new')
			end
		end
		
		context "when valid attributes" do
			it "should redirect to user page" do
				post signup_path, params: { user: valid_params }
				expect(response).to have_http_status(302)
			end
		end
	end
	
	describe "GET /users/:id/edit" do
		context "when user is not logged in" do
			it "should redirect to root url" do
				get edit_user_path(user)
				expect(response).to have_http_status(302)
			end
		end
		context "when user is trying to edit other user" do
			it "should redirect to root url" do
				login(user,user.password)
				get edit_user_path(other_user)
				expect(response).to have_http_status(302)
			end
		end
		context "when user edits his info" do
			it "should return success response" do
				login(user,user.password)
				get edit_user_path(user)
				expect(response).to have_http_status(302)
			end
		end
	end
	
	describe "GET /users/:id" do
		it "should return success response" do
			get user_path(user)
			expect(response).to have_http_status(200)
		end
	end
	
	describe "PATCH /user/:id" do
		context "when user is not logged in" do
			it "should redirect to root_url" do
				patch user_path(user), params: { user: {name: 'updated'} }
				expect(response).to have_http_status(302)
			end
		end
		
		context "when user is logged in" do
			context "when request to other user" do
				it "should redirect to root_url" do
					login(user,user.password)
					patch user_path(other_user), params: { user: { name: 'updated' } }
					expect(response).to have_http_status(302)
				end
			end

			context "when request to edit self with valid attributes" do
				it "should redirect to user page" do
					login(user,user.password)
					patch user_path(user), params: { user: { name: 'updated', password: '' } }
					expect(response).to have_http_status(302)
				end
			end
		end
	end
	
	describe "DELELE /user/:id" do
		context "when user is not admin" do
			it "should return success response" do
				login(user,user.password)
				delete user_path(other_user)
				expect(response).to have_http_status(302)
			end
		end
		context "when user is admin" do
			context "when user tries to delete other admin" do
				it "should redirect to users path" do
					login(super_user,super_user.password)
					delete user_path(super_user2)
					expect(response).to have_http_status(302)
				end
			end
			context "when user tries to delete other user" do
				it "should redirect to users path" do
					login(super_user,super_user.password)
					delete user_path(user)
					expect(response).to have_http_status(302)
				end
			end
		end
	end
end
