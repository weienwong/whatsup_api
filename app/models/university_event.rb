
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

  def self.show_events(category_id=nil, time=nil)

    min_time = DateTime.now.utc.to_s
    max_time = ''

    case time
    when 'today'
      max_time = DateTime.now.end_of_day.utc.to_s
    when 'week'
      max_time = DateTime.now.end_of_week.utc.to_s
    when 'this_month'
      max_time = DateTime.now.end_of_month.utc.to_s
    when 'next_month'
      min_time = DateTime.now.next_month.beginning_of_month.utc.to_s
      max_time = DateTime.now.next_month.end_of_month.utc.to_s
    end

    site_category_location_query = 
      'SELECT DISTINCT 
        university_events.id,
        university_events.name, 
        university_events.website, 
        university_event_time_locations.start_time, 
        university_event_time_locations.end_time, 
        locations.room, 
        locations.building_name,
        sites.name AS organizer
      FROM 
        public.university_event_categories, 
        public.university_event_time_locations, 
        public.university_events, 
        public.event_categories, 
        public.locations, 
        public.sites
      WHERE 
        university_events.created_at = (
            select max(university_events.created_at) from public.university_events
          ) AND
        university_event_categories.university_event_id = university_events.id AND 
        university_event_categories.event_category_id = event_categories.id AND
        university_event_time_locations.university_event_id = university_events.id AND
        university_event_time_locations.location_id = locations.id AND
        university_events.site_id = sites.id AND
        university_event_time_locations.end_time >= \'' + min_time + '\' AND 
        university_event_time_locations.end_time < \'' + max_time + '\''
    
      if category_id == '0'
        all_events_query = '
          SELECT DISTINCT 
            university_events.id, 
            university_events.name, 
            locations.room, 
            locations.building_name, 
            university_event_time_locations.start_time, 
            university_event_time_locations.end_time, 
            sites.name AS organizer, 
            university_events.website
          FROM 
            public.university_events, 
            public.university_event_time_locations, 
            public.sites, 
            public.locations
          WHERE 
            university_events.created_at = (
                select max(university_events.created_at) from public.university_events
              ) AND
            university_events.site_id = sites.id AND
            university_events.id = university_event_time_locations.university_event_id AND
            university_event_time_locations.location_id = locations.id AND

            university_event_time_locations.end_time >= \'' + min_time + '\' AND 
            university_event_time_locations.end_time < \'' + max_time + '\'
            ORDER BY university_event_time_locations.start_time'
        return UniversityEventTimeLocation.find_by_sql(all_events_query)
      else
        new_query = site_category_location_query +
                    ' AND event_categories.id = ' + category_id + 
                    ' ORDER BY university_event_time_locations.start_time'
        return UniversityEventTimeLocation.find_by_sql(new_query)
      end
  end

  def get_event_details

    event_id = self.id.to_s
    current_time = DateTime.now.utc.to_s
    
    when_where_query = '
      SELECT DISTINCT 
      university_events.id,
      university_event_time_locations.start_time, 
      university_event_time_locations.end_time, 
      locations.room, 
      locations.building_name, 
      locations.address, 
      locations.city, 
      locations.province, 
      locations.postal_code
    FROM 
      public.university_event_time_locations, 
      public.university_events, 
      public.locations 
    WHERE
      university_event_time_locations.university_event_id = university_events.id AND
      university_event_time_locations.end_time >= \'' + current_time  + '\'  AND
      locations.id = university_event_time_locations.location_id AND
      university_events.id = ' + event_id  +         
    'ORDER BY university_event_time_locations.start_time'

    when_where = UniversityEvent.find_by_sql(when_where_query)

    result = {:id => self.id,
              :name => self.name,
              :description => self.description,
              :website => self.website,
              :organized_by => self.site.name,
              :nearest_when_where => when_where[0],
              :later_when_where => when_where[1..-1]}

    return result
  end

  def create_event_invite(email_address=nil)

    event_details = self.get_event_details
    cal = Icalendar::Calendar.new

    cal_event = Icalendar::Event.new

    cal_event.dtstart = Icalendar::Values::DateTime.new(event_details[:nearest_when_where].start_time.localtime)
    cal_event.dtend = Icalendar::Values::DateTime.new(event_details[:nearest_when_where].end_time.localtime)
    cal_event.summary = event_details[:name]
    cal_event.location = event_details[:nearest_when_where].building_name + " " + event_details[:nearest_when_where].room
    
    cal.add_event(cal_event)
    cal.publish
    
    File.open("./ics/" + event_details[:id].to_s + ".ics", "w+") do |f|
      f.write(cal.to_ical)
    end

    begin
      RestClient.post "https://api:key-eafc5e70e6bcb71af6ba5d95c8132cf3"\
        "@api.mailgun.net/v3/sandbox3af273bc6e66458f9b9a4015b7d3a28e.mailgun.org/messages",
        :from => "WatsUp <mailgun@sandbox3af273bc6e66458f9b9a4015b7d3a28e.mailgun.org>",
        :to => email_address,
        :subject => event_details[:name],
        :text => "Event Name: " + event_details[:name] + "\n\n" + 
                  "Start Time: " + event_details[:nearest_when_where].start_time.localtime.to_formatted_s(:long_ordinal) + "\n\n" +
                  "End Time: " + event_details[:nearest_when_where].end_time.localtime.to_formatted_s(:long_ordinal) + "\n\n" +
                  "Location: " + event_details[:nearest_when_where].building_name + " " + event_details[:nearest_when_where].room + "\n\n" +
                  "Website: " + event_details[:website],

        :attachment => File.open("./ics/" + event_details[:id].to_s + ".ics", "r")  

    rescue => e
      puts e

    end

  
  end

end
