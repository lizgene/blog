require 'rails_helper'

RSpec.describe Photo, type: :model do
  it "has a valid factory"
  it "belongs to an album"
  it "uploads to s3 on create"
end
