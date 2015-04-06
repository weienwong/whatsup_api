require 'uwaterlooapi'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    
    render json: Event.get_events_by_category(0)

  end

  # GET /events/1
  # GET /events/1.json
  def show

    event_times = @event.get_times
    event_times_formatted = []

    
    @event_info = {
                  "name" => @event.name, 
                  "university" => @event.university.name,
                  "address" => @event.address,
                  "website" => @event.website,
                  "description" => @event.description,
                  "category" => @event.get_categories,
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
    
    render json: events_by_category

  end

  def get_events_by_category_and_university
    category_id = params[:category_id]
    university_id = params[:university_id]

    Event.get_events_by_category_university(category_id, university_id)

    #render json: {'category_id' => category_id, 'university_id' => university_id}
    render json: Event.get_events_by_category_university(category_id, university_id)
  end

  def get_events_by_time
    time = params[:when]
    category_id = params[:category_id]
    #render json: Event.get_events_by_time_category(time, category_id)
    render json: Event.get_events_with_multiple_times(time, category_id)
  end
  
  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :university_id, :start_time, :end_time, :location, :description)
    end
end
