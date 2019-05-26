require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
    render_views

    describe 'GET home' do
        it 'should get home ' do
            get :home
            expect(response).to have_http_status(:success)
            expect(response).to render_template("home")
        end

        # it 'should have proper title' do
        #     expect(response).should have_selector("title:contains('Ruby on Rails Sample App')")
        # end
    end

    describe 'GET help' do
        it 'should get help' do
           get :help
           expect(response).to have_http_status(:success) 
           expect(response).to render_template("help")
        end
    end

    describe 'GET about' do
        it 'should get about' do
            get :about
            expect(response).to have_http_status(:success)
            expect(response).to render_template("about")
        end
    end

    describe 'GET contact' do
        it 'should get contact' do
            get :contact
            expect(response).to have_http_status(:success)
            expect(response).to render_template("contact")
        end
    end
end
