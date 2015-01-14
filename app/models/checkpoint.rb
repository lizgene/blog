class Checkpoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

  geocoded_by :ip_address
  geocoded_by :street_address
  after_validation :geocode


end
