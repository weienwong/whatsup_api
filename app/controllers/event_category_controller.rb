class EventCategoryController < ApplicationController

  def index
    all_events_categories = EventCategory.all.select(:id, :category_name)
    render json: all_events_categories 
  end

end
