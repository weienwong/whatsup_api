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

    # validates_assoicated :university, 

    def get_address
      return address
    end

    # checks if event name is already taken
    def self.valid_event_name(event_name)
        
      if self.where("name=" + "'" + event_name + "'").empty?
        return true
      else
        return false
      end

    end

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
#        u_id = 1 

        #datatype sqlstr as string
        sqlstr = "SELECT distinct events.name as event_name, events.website, universities.name as university, event_times.start_time"
        sqlstr = sqlstr + " FROM ( (events INNER JOIN events_to_event_categories ON events.id = events_to_event_categories.event_id) "
        sqlstr = sqlstr + " INNER JOIN event_times ON events.id = event_times.event_id )"
        sqlstr = sqlstr + " INNER JOIN universities ON events.university_id = universities.id "
        sqlstr = sqlstr + " WHERE events_to_event_categories.event_category_id = " + category_id.to_s    
        sqlstr = sqlstr + " and event_times.start_time >= " + "'" + DateTime.now.to_s + "'"    
 #       sqlstr = sqlstr + " and universities.id = " + u_id.to_s

        #my_query = "select events.*, events_to_event_categories.* from events inner join events_to_event_categories on events.id = events_to_event_categories.event_id where events_to_event_categories.event_category_id  " 
        
        @connection = ActiveRecord::Base.connection

        if category_id == "0"
          result = @connection.exec_query(sqlstr + "> 0")
          result = Event.first(500)
          
        else
          result = @connection.exec_query(sqlstr)
        end

        return result
#      result.each do |row|
#        puts row
#      end

 #     if (category_id == "0")
 #       return Event.first(500)
 #     else
 #       event_ids = EventsToEventCategory.select("event_id").where(event_category_id: category_id)
 #       events = []

 #       event_ids.each do |event_id|
 #         events.push Event.find(event_id.event_id)
 #       end

 #       return events
 #     end

      
    end

end
