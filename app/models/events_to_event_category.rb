class EventsToEventCategory < ActiveRecord::Base
  belongs_to :event
  belongs_to :event_category
end
