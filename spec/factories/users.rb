
FactoryBot.define do
    factory :user do
      name {'random'}
      sequence(:email){|n| "user#{n}@factory.com" }
      password {'gaggag'}
      password_confirmation {'gaggag'}
      activated {true}
  
      trait(:super) { admin { true } }
  
      trait(:non_active) { activated { false } }
  
      factory :follower do end
      factory :following do end
    end
  end
