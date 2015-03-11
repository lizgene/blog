require 'rails_helper'

RSpec.describe Photo, type: :model do

  it "has a valid factory" do
    expect(create(:photo)).to be_valid
  end

  it "saves image on create via Carrierwave ImageUploader" do
    expect(create(:photo).image).to be_instance_of(ImageUploader)
  end

end
