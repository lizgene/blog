class Trip < ActiveRecord::Base
  has_many :checkpoints
  has_many :users, :through => :checkpoints

end
