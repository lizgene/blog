class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :slug
  before_validation :set_slug, on: :create

  def set_slug
    self.slug = self.title.downcase.gsub(" ", "-")
  end

  def to_param
    slug
  end
end
