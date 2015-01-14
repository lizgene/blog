class Checkpoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

  geocoded_by :ip_address
  after_validation :geocode

  # validates_presence_of :latitude, :longitude, :on => :create


end
