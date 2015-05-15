class Audience < ActiveRecord::Base
  has_many :university_event_to_audiences
  has_many :university_event, :through => :unviersity_event_to_audiences
end
