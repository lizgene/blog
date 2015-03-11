require 'rails_helper'

RSpec.describe Album, type: :model do
  it "has a valid factory" do
    expect(create(:album)).to be_valid
  end

  it "fails validation if title is not present" do  
    expect { FactoryGirl.create(:album, title: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "builds and saves slug on create" do
    album = FactoryGirl.create(:album)
    expect(album.slug).to eq(album.title.parameterize)
  end

  it "successfully creates an album without photos" do
    expect(create(:album).photos.length).to eq(0)
  end

  it "successfully creates an album with photos" do
    expect(create(:album_with_photos, photos_count: 7).photos.length).to eq(7)
  end

end
