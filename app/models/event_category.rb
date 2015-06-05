class EventCategory < ActiveRecord::Base
  has_many :events_to_event_categories
  has_many :events, :through => :events_to_event_categories

  has_many :university_event_categories
  has_many :university_events, :through => :university_event_categories


end
