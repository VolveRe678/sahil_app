FactoryBot.define do 
	factory :micropost do 
		user
		content { 'lorem ipsum dolor it' }
	end
end