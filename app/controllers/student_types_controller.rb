class StudentTypesController < ApplicationController
  before_action :set_student_type, only: [:show, :update, :destroy]

  # GET /student_types
  # GET /student_types.json
  def index
    @student_types = StudentType.all

    render json: @student_types
  end

  # GET /student_types/1
  # GET /student_types/1.json
  def show
    render json: @student_type
  end

  # POST /student_types
  # POST /student_types.json
  def create
    @student_type = StudentType.new(student_type_params)

    if @student_type.save
      render json: @student_type, status: :created, location: @student_type
    else
      render json: @student_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /student_types/1
  # PATCH/PUT /student_types/1.json
  def update
    @student_type = StudentType.find(params[:id])

    if @student_type.update(student_type_params)
      head :no_content
    else
      render json: @student_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /student_types/1
  # DELETE /student_types/1.json
  def destroy
    @student_type.destroy

    head :no_content
  end

  private

    def set_student_type
      @student_type = StudentType.find(params[:id])
    end

    def student_type_params
      params.require(:student_type).permit(:student_type)
    end
end
