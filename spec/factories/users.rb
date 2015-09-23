FactoryGirl.define do
  factory :user do
    password "12345678"
    sequence(:email) {|n| "user#{n}@example.com" }
  end
end
