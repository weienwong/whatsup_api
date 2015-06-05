class UniversitiesController < ApplicationController
  before_action :set_university, only: [:show, :update, :destroy]



  # GET /universities
  # GET /universities.json
  def index
    @universities = University.all

    render json: @universities.select('id','name')
  end

  # GET /universities/1
  # GET /universities/1.json
  def show
    render json: @university
  end

  # POST /universities
  # POST /universities.json
  def create
    @university = University.new(university_params)

    if @university.save
      render json: @university, status: :created, location: @university
    else
      render json: @university.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /universities/1
  # PATCH/PUT /universities/1.json
  def update
    @university = University.find(params[:id])

    if @university.update(university_params)
      head :no_content
    else
      render json: @university.errors, status: :unprocessable_entity
    end
  end

  # DELETE /universities/1
  # DELETE /universities/1.json
  def destroy
    @university.destroy

    head :no_content
  end

  private

    def set_university
      @university = University.find(params[:id])
    end

    def university_params
      params.require(:university).permit(:name)
    end
end
