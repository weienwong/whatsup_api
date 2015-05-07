class UniversityEventTimeLocation < ActiveRecord::Base
  belongs_to :university_event
  belongs_to :location
end
