class Checkpoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  belongs_to :post

  geocoded_by :ip_address
  geocoded_by :street_address
  after_validation :geocode


end
