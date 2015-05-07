class Organizer < ActiveRecord::Base
  has_many :university_event_organizers
  has_many :university_events, :through => :university_event_organizers
     

end
