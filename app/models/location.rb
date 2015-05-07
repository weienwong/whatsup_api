class Location < ActiveRecord::Base
  has_many :university_event_time_locations
  has_many :university_events, :through => :university_event_time_locations
end
