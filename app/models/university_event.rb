class UniversityEvent < ActiveRecord::Base
  has_many :university_event_time_locations 
  has_many :locations, :through => :university_event_time_locations

  has_many :university_event_organizers
  has_many :organizers, :through => :university_event_organizers

  has_many :university_event_categories
  has_many :event_categories, :through => :university_event_categories

  def get_start_end
    all_start_end = []

    university_event_time_locations.each do |r|
      all_start_end.append({:start => r.start_time, :end => r.end_time})
    end
    
    return all_start_end

  end

  # gets an event as well as its associated times and locations
  def self.show_all_events_info
    all_events = UniversityEvent.all
    result = []

    all_events.each do |e|
      result.append({:event => e, :event_type => e.event_categories, :times => e.get_start_end, :where => e.locations })
    end

    return result
  end



end
