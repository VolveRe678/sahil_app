require 'rails_helper'
module TestHelpers
         def login(user,password)
            visit '/login'
            fill_in 'session_email', with: user.email
            fill_in 'session_password', with: password
            click_button 'Log in'
            # session[:user_id] = user.id
         end

         def log_in(user)
           session[:user_id] = user.id
         end
end
