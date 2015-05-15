class UnviersityEventToAudience < ActiveRecord::Base
  belongs_to :university_event
  belongs_to :audience
end
