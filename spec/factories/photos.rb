FactoryGirl.define do
  factory :photo do
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/test-photo-upload.jpg')))
    album
  end
end
