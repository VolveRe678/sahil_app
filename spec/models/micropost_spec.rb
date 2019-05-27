require 'rails_helper'

RSpec.describe Micropost, type: :model do
	describe "Association" do
		it {should belong_to(:user)}
	end
	
	describe "valid attributes" do
		it {should validate_presence_of(:content)}
		it {should validate_length_of(:content).is_at_most(140)}
		it {should validate_presence_of(:user_id)}
	
end

end
