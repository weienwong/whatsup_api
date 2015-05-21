class SiteController < ApplicationController

  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
  def index
    sites = Site.all.select(:id, :name)
    render json: sites
  end

end
