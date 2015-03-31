class Event < ActiveRecord::Base
    belongs_to :university
    belongs_to :address

    has_many :event_times

    has_many :events_to_event_categories
    has_many :event_categories, :through => :events_to_event_categories
    
    validates :name, :presence => true
    validates :university_id, :presence => true
    validates :start_time, :presence => true
    validates :end_time, :presence => true
    validates :location, :presence => true


    def get_categories
      category_names = []
      event_categories.each do |category|
        category_names.push category.category_name
      end
      return category_names

    end

    def get_times
      event_time_list = []

      event_times.each do |time|
        start_time = time.start_time
        end_time = time.end_time
    
        event_time_list << {'start_time' => start_time, 'end_time' => end_time}

      end

      return event_time_list
      
    end

    def get_closest_start_time

      event_times.each do |time|
        start_time = time.start_time

        if DateTime.now <= start_time
          return start_time
        else
          return nil
        end

      end
    end



    def self.get_events_by_category(category_id)
        result = []
        
        event_today = []
        event_this_week = []
        event_this_month = []
        later_events = []

        #datatype sqlstr as string

        @connection = ActiveRecord::Base.connection

        if category_id.to_s == "0"

          sqlstr = "SELECT distinct events.name as event_name, events.website, universities.name as university, event_times.start_time"
          sqlstr = sqlstr + " FROM ((events INNER JOIN events_to_event_categories ON events.id = events_to_event_categories.event_id) "
          sqlstr = sqlstr + " INNER JOIN event_times ON events.id = event_times.event_id)"
          sqlstr = sqlstr + " INNER JOIN universities ON events.university_id = universities.id "
          sqlstr = sqlstr + " WHERE event_times.start_time >= " + "'" + DateTime.now.to_s + "'"    
          
          result = @connection.exec_query(sqlstr)
          
        else
          sqlstr = "SELECT distinct events.name as event_name, events.website, universities.name as university, event_times.start_time"
          sqlstr = sqlstr + " FROM ((events INNER JOIN events_to_event_categories ON events.id = events_to_event_categories.event_id) "
          sqlstr = sqlstr + " INNER JOIN event_times ON events.id = event_times.event_id)"
          sqlstr = sqlstr + " INNER JOIN universities ON events.university_id = universities.id "
          sqlstr = sqlstr + " WHERE events_to_event_categories.event_category_id = " + category_id.to_s    
          sqlstr = sqlstr + " and event_times.start_time >= " + "'" + DateTime.now.to_s + "'"    
#        sqlstr = sqlstr + " and universities.id = " + university_id.to_s
          
          result = @connection.exec_query(sqlstr)
        end

        result.each do |event|
          if event['start_time'].to_date == DateTime.now.to_date
            event_today << event
          elsif event['start_time'].to_date.strftime("%U") == DateTime.now.strftime("%U")
            event_this_week << event
          elsif event['start_time'].to_date.strftime("%m") == DateTime.now.strftime("%m")
            event_this_month << event
          else
            later_events << event
          end

        end

        all_events = {'event_today' => event_today, 
                      'event_this_week' => event_this_week, 
                      'event_this_month' => event_this_month, 
                      'later_events' => later_events}

        return all_events
    end

end
