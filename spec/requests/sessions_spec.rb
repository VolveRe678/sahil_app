require 'rails_helper'

RSpec.describe "Sessions", type: :request do
	let(:user) {create(:user)}
	let(:valid_params) {build(:user).attributes.merge(password: 'gaggag',email:
			user.email)}
	let(:invalid_params) {valid_params.merge(password:'wrongpassword')}
	
	describe "GET /sessions/new" do
		it "should respond successful" do
			get login_path
			expect(response).to have_http_status(200)
		end
	end
	
	describe "POST /login" do
		context "when params are invalid" do
			it "should respond successful" do
				post login_path, params: { session: invalid_params }
				expect(response).to have_http_status(200)
			end
		end
		
		context "when params are valid" do
			it "should redirect to user page" do
				post login_path, params: { session: valid_params }
				expect(response).to have_http_status(302)
			end
		end
	end
end
