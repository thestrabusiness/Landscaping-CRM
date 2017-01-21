FactoryGirl.define do
  
  factory :user do
    email               "johnson@gmail.com"
    password            Devise.bcrypt(User, 'password')
    confirmed_at        Date.today
  end
    
end
