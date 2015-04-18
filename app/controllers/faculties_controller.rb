class FacultiesController < ApplicationController
  before_action :set_faculty, only: [:show, :update, :destroy]

  # GET /faculties
  # GET /faculties.json
  def index
    @faculties = Faculty.select(:faculty, :faculty_short)

    render json: @faculties
  end

  # GET /faculties/1
  # GET /faculties/1.json
  def show
    render json: @faculty
  end

  # POST /faculties
  # POST /faculties.json
  def create
    @faculty = Faculty.new(faculty_params)

    if @faculty.save
      render json: @faculty, status: :created, location: @faculty
    else
      render json: @faculty.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /faculties/1
  # PATCH/PUT /faculties/1.json
  def update
    @faculty = Faculty.find(params[:id])

    if @faculty.update(faculty_params)
      head :no_content
    else
      render json: @faculty.errors, status: :unprocessable_entity
    end
  end

  # DELETE /faculties/1
  # DELETE /faculties/1.json
  def destroy
    @faculty.destroy

    head :no_content
  end

  private

    def set_faculty
      @faculty = Faculty.find(params[:id])
    end

    def faculty_params
      params.require(:faculty).permit(:faculty, :faculty_short)
    end
end
