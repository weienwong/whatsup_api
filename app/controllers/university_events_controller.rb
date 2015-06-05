
class UniversityEventsController < ApplicationController
  before_action :set_university_event, only: [:show, :update, :destroy]


  # GET /university_events
  # GET /university_events.json
  def index
    category_id = params[:category_id]
    time = params[:time]
    result = UniversityEvent.show_events(category_id, time)

    render json: result
  end

  # GET /university_events/1
  # GET /university_events/1.json
  def show
    result = @university_event.get_event_details()

    render json: result
  end

  # POST /university_events/
  def send_invite
    uni_event_id = params[:uni_event_id]
    email = params[:email]

    @university_event = UniversityEvent.find uni_event_id
    render json: @university_event.create_event_invite(email)

  end

  # POST /university_events
  # POST /university_events.json
  def create
    @university_event = UniversityEvent.new(university_event_params)

    if @university_event.save
      render json: @university_event, status: :created, location: @university_event
    else
      render json: @university_event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /university_events/1
  # PATCH/PUT /university_events/1.json
  def update
    @university_event = UniversityEvent.find(params[:id])

    if @university_event.update(university_event_params)
      head :no_content
    else
      render json: @university_event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /university_events/1
  # DELETE /university_events/1.json
  def destroy
    @university_event.destroy

    head :no_content
  end

  private

    def set_university_event
      @university_event = UniversityEvent.find(params[:id])
    end

    def university_event_params
      params[:university_event]
    end
end
