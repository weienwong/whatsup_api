class EventCategoriesController < ApplicationController
  before_action :set_event_category, only: [:show, :update, :destroy]

  # GET /event_categories
  # GET /event_categories.json
  def index
    @event_categories = EventCategory.select("id, category_name").order(:priority)

    pluralize_categories = []

    @event_categories.each do |c| 
      pluralize_categories << {:id => c["id"], :category_name => c.category_name.to_s.pluralize}
    end

    render json: pluralize_categories
#    render json: @event_categories
  end

  # GET /event_categories/1
  # GET /event_categories/1.json
  def show
    render json: @event_category
  end

  # POST /event_categories
  # POST /event_categories.json
  def create
    @event_category = EventCategory.new(event_category_params)

    if @event_category.save
      render json: @event_category, status: :created, location: @event_category
    else
      render json: @event_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_categories/1
  # PATCH/PUT /event_categories/1.json
  def update
    @event_category = EventCategory.find(params[:id])

    if @event_category.update(event_category_params)
      head :no_content
    else
      render json: @event_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /event_categories/1
  # DELETE /event_categories/1.json
  def destroy
    @event_category.destroy

    head :no_content
  end

  private

    def set_event_category
      @event_category = EventCategory.find(params[:id])
    end

    def event_category_params
      params.require(:event_category).permit(:category_name)
    end
end
