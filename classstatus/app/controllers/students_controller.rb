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
    count = 0; enrolled = 0; dupes = 0; msg = ""

    file = params[:file]

    @roster =
    case File.extname(file)
    when '.xml'  then Roo::Spreadsheet.open(file.path)
    else nil
    end

    if (@roster == nil)
      redirect_to students_path,
        alert: "Unable to import #{file.original_filename}: unsupported file type \'#{File.extname(file)}\'"
    else
      students = skyward_parse

      students.each do |s|
        if (Student.exists?(guid: s['guid']))
          @student = Student.find_by(guid: s['guid'])
          # TODO: some of the student information may have changed - especially
          #       their GPA - so we need to do something about checking and
          #       updating the record.
          updated_attributes = @student.merge_attributes(s)
          @student.update(updated_attributes)
          dupes += 1
        else
          @student = Student.new(s)
          if (@student.gpa == nil)
            @student.gpa_updated = nil
          end
          @student.save
          count += 1
        end

        if (params[:section] != '')
          enroll_student(@student, params[:section], Date.iso8601('2020-01-31'))
          enrolled += 1
        end
      end

      msg += "Imported #{count} students from #{params[:file].original_filename}. "
      if (params[:section] != '')
        msg += "Enrolled #{enrolled} students in #{Section.find(params[:section]).name}. "
      end
      msg += "Skipped #{dupes} students who were already in the database."

      redirect_to students_path,
        notice: msg
    end
  end

  def skyward_parse
    export_date = @roster.row(1)[6].sub('Date: ', '')
    export_time = @roster.row(2)[6].sub('Time: ', '')
    timestamp = mmddyyyy_to_iso(export_date, export_time)

    students = []
    8.upto(@roster.last_row) do |i|
      students.push(skyward_process_row(@roster.row(i), timestamp))
    end
    students
  end

  def skyward_process_row(row, timestamp)
    student = Student.new()

    student.guid = row[1]

    name_array = row[0].strip.split(/,\s*/)
    student.family_name = name_array[0]
    student.given_name = name_array[1].sub(/\s\w\.$/, '')

    student.dob = mmddyyyy_to_iso(row[2])
    student.gender = row[4] == 'Male' ? 'M' : 'F'
    student.cohort = row[5]
    student.gpa = row[3]
    student.gpa_updated = timestamp

    student
  end

  def mmddyyyy_to_iso(date, time = nil)
    # Skward exports dates as MM/DD/YYYY and MM/DD/YY
    tmp = date.split('/')
    tmp[2] = (tmp[2].to_i + 2000).to_s if tmp[2].length == 2
    date = "#{tmp[2]}-#{tmp[0]}-#{tmp[1]}"
    if (time == nil)
      date
    else
      "#{date}T#{time}#{Time.now.getlocal.formatted_offset}"
    end
  end

  def enroll_student(student, section, date = Date.today)
    if (!Enrollment.exists?(student_id: student, section_id: section))
      @enrollment = Enrollment.new()
      @enrollment.student_id = student.id
      @enrollment.section_id = section
      @enrollment.joined_course = date
      @enrollment.save
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
      params.require(:student).permit(
        :guid, :preferred_name, :given_name, :family_name, :pronouns,
        :gender, :dob, :cohort, :gpa, :gpa_updated
      )
    end

    # Helpers for sortable table columns.
    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : 'family_name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
