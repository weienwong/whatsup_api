class SiteController < ApplicationController

  def index
    sites = Site.all.select(:id, :name)
    render json: sites
  end

end
