require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  describe 'user with valid attributes' do
    before do
      user
    end
    it "should be valid" do
      user
      expect(user).to be_valid
		end

    # should have email attributes
    it { should validate_presence_of :email }
    # unique email
    it { should validate_uniqueness_of(:email).case_insensitive }
    #email length
    it { should validate_length_of(:email).is_at_most(255) }
    # should have name attributes
    it { should validate_presence_of :name }
    #name length
    it { should validate_length_of(:name).is_at_most(50) }
    # should have password
    it { should validate_presence_of :password }
    # length of password
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:password).is_at_most(72) }
	end

  describe 'Association' do
    it { should have_many(:microposts) }
    it { should have_many(:active_relationships) }
    it { should have_many(:passive_relationships) }
    it { should have_many(:following) }
    it { should have_many(:followers) }
  end
end
