class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title
  before_create :set_slug
  has_many :checkpoints

  def set_slug
    self.slug = self.title.parameterize 
  end

  def to_param
    slug
  end
end
