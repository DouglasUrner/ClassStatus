class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /enrollments
  def index
    @enrollments = Enrollment.order(sort_column + " " + sort_direction)
  end

  # GET /enrollments/1
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  def create
    @enrollment = Enrollment.new(enrollment_params)

    if @enrollment.save
      redirect_to enrollments_path,
        notice: 'Enrollment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /enrollments/1
  def update
    if @enrollment.update(enrollment_params)
      redirect_to enrollments_path,
        notice: 'Enrollment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /enrollments/1
  def destroy
    @enrollment.destroy
    redirect_to enrollments_url,
      notice: 'Enrollment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def enrollment_params
      params.require(:enrollment).permit(:student_id, :section_id, :joined_course, :joined_section, :dropped_course)
    end

    # Helpers for sortable table columns.
    def sort_column
      Enrollment.column_names.include?(params[:sort]) ? params[:sort] : 'section_id'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
