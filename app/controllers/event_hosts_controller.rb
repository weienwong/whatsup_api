class EventHostsController < ApplicationController
  before_action :set_event_host, only: [:show, :update, :destroy]

  # GET /event_hosts
  # GET /event_hosts.json
  def index
    @event_hosts = EventHost.all

    render json: @event_hosts
  end

  # GET /event_hosts/1
  # GET /event_hosts/1.json
  def show
    render json: @event_host
  end

  # POST /event_hosts
  # POST /event_hosts.json
  def create
    @event_host = EventHost.new(event_host_params)

    if @event_host.save
      render json: @event_host, status: :created, location: @event_host
    else
      render json: @event_host.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_hosts/1
  # PATCH/PUT /event_hosts/1.json
  def update
    @event_host = EventHost.find(params[:id])

    if @event_host.update(event_host_params)
      head :no_content
    else
      render json: @event_host.errors, status: :unprocessable_entity
    end
  end

  # DELETE /event_hosts/1
  # DELETE /event_hosts/1.json
  def destroy
    @event_host.destroy

    head :no_content
  end

  private

    def set_event_host
      @event_host = EventHost.find(params[:id])
    end

    def event_host_params
      params.require(:event_host).permit(:host_name, :description, :website)
    end
end
