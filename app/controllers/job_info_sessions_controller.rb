class JobInfoSessionsController < ApplicationController
  before_action :set_job_info_session, only: [:show, :update, :destroy]

  # GET /job_info_sessions
  # GET /job_info_sessions.json
  def index
    @job_info_sessions = JobInfoSession.all.select(:employer, :start_time, :location, :website, :education_level, :student_type, :faculties)

    render json: @job_info_sessions
  end

  # GET /job_info_sessions/1
  # GET /job_info_sessions/1.json
  def show
    render json: @job_info_session
  end

  # POST /job_info_sessions
  # POST /job_info_sessions.json
  def create
    @job_info_session = JobInfoSession.new(job_info_session_params)

    if @job_info_session.save
      render json: @job_info_session, status: :created, location: @job_info_session
    else
      render json: @job_info_session.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_info_sessions/1
  # PATCH/PUT /job_info_sessions/1.json
  def update
    @job_info_session = JobInfoSession.find(params[:id])

    if @job_info_session.update(job_info_session_params)
      head :no_content
    else
      render json: @job_info_session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /job_info_sessions/1
  # DELETE /job_info_sessions/1.json
  def destroy
    @job_info_session.destroy

    head :no_content
  end

  private

    def set_job_info_session
      @job_info_session = JobInfoSession.find(params[:id])
    end

    def job_info_session_params
      params.require(:job_info_session).permit(:employer, :start_time, :end_time, :website, :target_audience, :description)
    end
end
