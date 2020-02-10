class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /students
  def index
    @students = Student.order(sort_column + " " + sort_direction)
  end

  # GET /students/1
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student,
        notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      redirect_to @student,
        notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    redirect_to students_url,
      notice: 'Student was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:guid, :preferred_name, :given_name, :family_name, :pronouns, :gender, :dob, :cohort, :gpa, :gpa_updated)
    end

    # Helpers for sortable table columns.
    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : 'family_name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
