class UniversityEvent < ActiveRecord::Base

  has_many :university_event_time_locations 
  has_many :locations, :through => :university_event_time_locations

  has_many :university_event_organizers
  has_many :organizers, :through => :university_event_organizers

  has_many :university_event_categories
  has_many :event_categories, :through => :university_event_categories

  has_many :university_event_to_audience
  has_many :audiences, :through => :university_event_to_audiences

  belongs_to :site

  def get_start_end

    all_start_end = UniversityEventTimeLocation.where("university_event_id = ?", self.id).where("end_time >= ?", DateTime.now.utc()).select(:start_time, :end_time)
    
    return all_start_end

  end

  # takes in a site_id that represents the site, an event is assoicated with
  # takes in a category_id that represents the category, an event is assoicated with
  # time represents a timeframe in which an event takes place

  def self.show_events(site_id=nil, category_id=nil, time=nil)
    
    # filter out by site first, then by category, then by time
    events_by_site = []
    events_by_category = []

    if site_id == '0' or site_id.nil?
      events_by_site = UniversityEvent.includes(:university_event_time_locations, :locations)
    else
      events_by_site = UniversityEvent.includes(:university_event_time_locations, :locations).where("site_id = ?", site_id)
    end
    
    if category_id == '0' or category_id.nil?
      events_by_category = events_by_site
    else
      # looks for records in the university_event_categories table given an inputted category_id
      events_to_categories_by_category_id = UniversityEventCategory.where("event_category_id = ?", category_id)
      events_by_category = events_by_site.joins(:university_event_categories).merge(events_to_categories_by_category_id)
    end

    # return events_by_category
    
    # to find events by day, look through the university_events_time_locations table 
    # and isolate by day
    result = []

    if time == 'today'
      todays_events = UniversityEventTimeLocation.where(end_time: (DateTime.now.utc..DateTime.now.utc.end_of_day))
      result = events_by_category.joins(:university_event_time_locations).merge(todays_events)

    elsif time == 'this_week'
      this_weeks_events = UniversityEventTimeLocation.where(end_time: (DateTime.now.utc..DateTime.now.utc.end_of_week))
      result = events_by_category.joins(:university_event_time_locations).merge(this_weeks_events)

    elsif time == 'this_month'
      this_months_events = UniversityEventTimeLocation.where(end_time: (DateTime.now.utc..DateTime.now.utc.end_of_month))
 
      result = events_by_category.joins(:university_event_time_locations).merge(this_months_events)

    elsif time == 'next_month'

      next_months_events = UniversityEventTimeLocation.where(end_time: (DateTime.now.beginning_of_month.utc + 1.month..DateTime.now.beginning_of_month.utc + 2.month))
 
      result = events_by_category.joins(:university_event_time_locations).merge(next_months_events)

    end

    events_result = []

    result.each do |r|
      
      event_times = []
      when_where = []
      
      r.university_event_time_locations.each do |t|

        if t.end_time >= DateTime.now.utc
          event_times << {:start_time => t.start_time, :end_time => t.end_time}
        end
      end

      events_result << {:event_id => r.id,
                        :website => r.website,
                        :event_name => r.name, 
                        :times => event_times.first,
                        :locations => r.locations.first.building_name + " " + r.locations.first.room

      }
      end

    return events_result

  end

  def get_event_details

    time_locations = self.university_event_time_locations.includes(:location)

    sorted_time_locations = time_locations.sort {|a,b| a.start_time <=> b.start_time}

    when_where = []

    sorted_time_locations.each do |tl|

      if tl.end_time >= DateTime.now.utc
        when_where << {:start => tl.start_time, 
                       :end => tl.end_time, 
                       :building_name => tl.location.building_name,
                       :room => tl.location.room,
                       :address => tl.location.address,
                       :city => tl.location.city,
                       :province => tl.location.province
        }
      end
    end


    result = {
      :id => self.id,
      :event_name => self.name,
      :event_description => self.description,
      :event_website => self.website,
      :when_where => when_where,
      :organizer => self.site.name
    }

    return result
  end

end
