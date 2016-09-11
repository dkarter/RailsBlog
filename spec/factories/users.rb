FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    sequence(:name) { |n| "user#{n}"  }
    password 'password'
  end
end
