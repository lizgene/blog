require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has a valid factory" do
    expect(create(:post)).to be_valid
  end

  it "fails validation if title is not present" do  
    expect { FactoryGirl.create(:post, title: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "builds and saves slug on create" do
    post = FactoryGirl.create(:post)
    expect(post.slug).to eq(post.title.parameterize)
  end
end

