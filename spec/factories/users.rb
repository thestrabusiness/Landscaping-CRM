FactoryGirl.define do

  factory :user do
    email                 "johnson@gmail.com"
    password              'password1'
    password_confirmation 'password1'
    confirmed_at          Date.today
  end

end
