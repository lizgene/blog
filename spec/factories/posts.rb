FactoryGirl.define do
  factory :post do
    title { Faker::Company.catch_phrase }
  end
end