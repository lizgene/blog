FactoryGirl.define do
  factory :album do
    title { Faker::Company.catch_phrase }

    # album_with_photos will create photo data after the album has been created
    factory :album_with_photos do
      # photo_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        photos_count 5
      end

      # the after(:create) yields two values; the album instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the album is associated properly to the photo
      after(:create) do |album, evaluator|
        create_list(:photo, evaluator.photos_count, album: album)
      end
    end
  end
end
