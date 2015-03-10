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
end
