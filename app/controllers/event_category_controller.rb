class EventCategoryController < ApplicationController

  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
  def index
    all_events_categories = EventCategory.all.select(:id, :category_name)
    render json: all_events_categories 
  end

end
