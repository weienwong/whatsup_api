class UniversityEventTimeLocation < ActiveRecord::Base
  belongs_to :university_event
  belongs_to :location

  def self.get_times_and_locations(event_id)

    result = UniversityEventTimeLocation.where("university_event_id = ?", event_id)
    return result

  end

  def self.get_times(event_id)
    result = UniversityEventTimeLocation.where("university_event_id = ?", event_id).where("start_time >= ?", DateTime.now.utc).select(:start_time, :end_time)
    return result
  end





end
