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

  # POST /students/import
  def import
    file = params[:file]

    roster =
    case File.extname(file)
    when '.xml'  then Roo::Spreadsheet.open(file.path)
    else nil
    end

    if (roster == nil)
      redirect_to students_path,
        alert: "Unable to import #{file.original_filename}: unsupported file type \'#{File.extname(file)}\'"
    else
      export_date = roster.row(1)[6].sub('Date: ', '')
      export_time = roster.row(2)[6].sub('Time: ', '')

      8.upto(roster.last_row) do |i|
        row = roster.row(i)
        s = Student.new()

        s.guid = row[1]

        name_array = row[0].strip.split(/,\s*/)
        s.family_name = name_array[0]
        s.given_name = name_array[1].sub(/\s\w\.$/, '')

        s.dob = row[2]
        s.gender = row[4] == 'Male' ? 'M' : 'F'
        s.cohort = row[5]
        s.gpa = row[3]
        s.gpa_updated = export_date

        s.save
      end
      redirect_to students_path,
        notice: "Imported students."
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
