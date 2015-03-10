FactoryGirl.define do
  factory :album do
    title { Faker::Company.catch_phrase }
  end
end
