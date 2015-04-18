class JobInfoSessionsController < ApplicationController
  before_action :set_job_info_session, only: [:show, :update, :destroy]

  # GET /job_info_sessions
  # GET /job_info_sessions.json
  def index

    time = ''
    faculty = ''
    student_type = ''

    if !params[:time].nil?
      time = params[:time]
    end
    
    if !params[:faculty].nil?
      faculty = params[:faculty]
    end
    
    if !params[:student_type].nil?
      student_type = params[:student_type]
    end

    result = []

    if time != ''
      result = JobInfoSession.show_session_by_time(time).show_session_by_faculty(faculty).show_session_by_student_type(student_type)
    end

    render json: result

  end

  def show_info_session_by_time
    time = params[:when]
    result = JobInfoSession.show_session_by_time(time)
    render json: result

  end

  def show_info_session_by_faculty
    faculty = params[:faculty]
    result = JobInfoSession.show_session_by_faculty(faculty)
    render json: result
  end

  def show_info_session_by_student_type
    student_type = params[:student_type]
    result = JobInfoSession.show_session_by_student_type(student_type)

    render json: result
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
