class UniverstiyEventOrganizer < ActiveRecord::Base
  belongs_to :university_event
  belongs_to :organizer
end
