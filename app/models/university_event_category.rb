class UniversityEventCategory < ActiveRecord::Base
  belongs_to :university_event
  belongs_to :event_category

end
