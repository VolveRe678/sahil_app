require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}
  let(:user1) { create(:user, :super, name: "Sahil", email: "s@y.com",
											 password:"123456", password_confirmation:"123456") }
  let(:other_user) { create(:user) }

  let(:micropost) { create(:micropost, user: user) }

  describe 'Association' do
    it { should have_many(:microposts) }
    it { should have_many(:active_relationships) }
    it { should have_many(:passive_relationships) }
    it { should have_many(:following) }
    it { should have_many(:followers) }
  end

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
    # it 'should validate presence of email' do
		#
    # end
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

    it 'should only accept valid address' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user.valid?).to be true
      end
		end

    it 'should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
				expect(user.valid?).to be false
      end
		end

    it 'should only save email as lower-case' do
			expect(user).to receive(:downcase_email){true}
			user.save
		end

    it 'should destroy associated microposts' do
      expect{micropost}.to change(Micropost,:count).by(1)
			# expect(Micropost.count).to eq 1
			expect{user.destroy}.to change(Micropost,:count).by(-1)
      # expect(Micropost.count).to eq 0
    end
	end
	
	describe '.downcase_email' do
		before do
		  user.email = mixed_case_email
			user.send(:downcase_email)
		end
		context "when email is empty string" do
			let(:mixed_case_email){ "" }
			it 'should only save email as lower-case' do
				expect(user.email).to eql("")
			end
		end
		
		context "when email is nil" do
			let(:mixed_case_email){ nil }
			it 'should only save email as lower-case' do
				expect(user.email).to eql(nil)
			end
		end
		
		context "when email is not nil" do
			let(:mixed_case_email){ "Foo@Example.com" }
			it 'should only save email as lower-case' do
				expect(user.email).to eql(mixed_case_email.downcase)
			end
		end
		
	end

	describe "follow" do
		it 'should follow a user' do
			expect{user.follow(user1)}.to change{ user.following.count }.by(1)
		
		end
	end

	describe "following" do
		it 'should be following another user' do
			user.follow(user1)
			expect(user.following).to include(user1)
			expect(user1.followers).to include(user)
		end
	end

	describe 'unfollow' do
   it 'should unfollow a user' do
		 user.follow(user1)
		 expect { user.unfollow(user1) }.to change { user.following.count }.by(-1)
   end
 end
	

  describe "feed" do
    it 'should have the right posts' do
			user1.microposts.each do |post_following|
			  expect(user.feed.include?(post_following)).to be true
			end
		end
	end

	
end
