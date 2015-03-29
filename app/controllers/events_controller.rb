require 'uwaterlooapi'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  # GET /events.json
  def index

    @events_output = []
    @events = Event.first(500)

    @events.each{ |event|

      if event.get_closest_start_time != [] and event.get_closest_start_time != nil
        closest_start_date = event.get_closest_start_time.strftime("%A %B %d, %Y")
        closest_start_time = event.get_closest_start_time.strftime("%I:%M %p")

        @events_output.push({
                          "event_id" => event.id,
                          "event_name" => event.name, 
                          "university" => event.university.name,
                          "website" => event.website,
                          "closest_start_date" => closest_start_date,
                          "closest_start_time" => closest_start_time,

                          })
      end
    }

    render json: @events_output
  end

  # GET /events/1
  # GET /events/1.json
  def show

    event_times = @event.get_times
    event_times_formatted = []

    event_times.each do |event_time|

      if event_time["end_time"] > DateTime.now
        
        start_date = event_time["start_time"].strftime("%A %B %d, %Y")
        end_date = event_time["end_time"].strftime("%A %B %d, %Y")
        
        start_time_of_day = event_time["start_time"].strftime("%I:%M %p")
        end_time_of_day = event_time["end_time"].strftime("%I:%M %p")
        
        event_times_formatted << {"start_date" => start_date, 
                                  "start_time" => start_time_of_day, 
                                  "end_date" => end_date, 
                                  "end_time" => end_time_of_day
                                }
      end
    end
    
    @event_info = {
                  "name" => @event.name, 
                  "university" => @event.university.name,
                  "address" => @event.address,
                  "website" => @event.website,
                  "description" => @event.description,
                  "category" => @event.get_categories,
                  "time" => event_times_formatted,
#                  "start_date" => start_date,
#                  "start_time_of_day" => start_time_of_day,
#                  "end_date" => end_date,
#                  "end_time_of_day" => end_time_of_day,
                  }

    render json: @event_info
  end

  # POST /events
  # POST /events.json
  def create
    # takes in event_name and unviersity_id
    # checks if event_name already exists
    # check if university id is valid
    
    if Event.valid_event_name(event_params[:name]) == false
      render json: {"error" => "Event Name already exists!"}
    elsif University.valid_university_id(event_params[:university_id]) == false
      render json: {"error" => "University does not exist!"}
    else

      @event = Event.new(event_params)
      if @event.save
        render json: @event, status: :created, location: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update

    if Event.valid_event_name(event_params[:name]) == false
      render json: {"error" => "Event Name already exists!"}
    elsif University.valid_university_id(event_params[:university_id]) == false
      render json: {"error" => "University does not exist!"}
    else

      @event = Event.find(params[:id])

      if @event.update(event_params)
        # head :no_content
        render json: {"status" => "update successful!", "event" => @event }
      else
        render json: @event.errors, status: :unprocessable_entity
      end
      
    end
    
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    head :no_content
  end

  def uw_events
    api = UWaterlooAPI.new '2d45f032cc37128113db2689f19067ee'
    events = api.events

    render json: events

  end

  def show_event_by_category

    category_id = params[:id]

    events_by_category = Event.get_events_by_category(category_id)

    
    formatted_events = []
    
    events_by_category.each do |event|

      if event["start_time"] != [] and event["start_time"] != nil
        
        start_time = DateTime.strptime event["start_time"]
        closest_start_date = start_time.strftime("%A %B %d, %Y")
        closest_start_time = start_time.strftime("%I:%M %p")
        
        formatted_events.push({
                          "event_name" => event["event_name"], 
                          "university" => event["university"],
                          "website" => event["website"],
                          "closest_start_date" => closest_start_date,
                          "closest_start_time" => closest_start_time,

                          })
      end
    end
      render json: formatted_events 
  end


  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :university_id, :start_time, :end_time, :location, :description)
    end
end
