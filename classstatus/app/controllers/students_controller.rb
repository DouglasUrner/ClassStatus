require 'json'

class StudentsController < ApplicationController
  helper StudentsHelper
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.order(:family_name).order(:preferred_name).order(:given_name)
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students/import
  def import
    count = 0; enrolled = 0; dupes = 0; msg = ""

    roster = JSON.parse( File.read(params[:file].path) )

    roster['students'].map do |s|

      p = ActionController::Parameters.new(student: s)

      # Check to see if we've already imported this student before proceeding.
      if (Student.exists?(guid: s['guid']))
        @student = Student.find_by(guid: s['guid'])
        dupes += 1
        # TODO: some of the student information may have changed - especially
        #       their GPA - so we need to do something about checking and
        #       updating the record.
      else
        @student = Student.new(student_params(p))
        if (@student.gpa == nil)
          @student.gpa_updated = nil
        end
        @student.save!
        count += 1
      end

      # Enroll new students in section
      if (params[:section] != '')
        if (!Enrollment.exists?(student_id: @student, section_id: params[:section]))
          @enrollment = Enrollment.new()
          @enrollment.student_id = @student.id
          @enrollment.section_id = params[:section]
          # TODO: add active flag to Enrollment
          @enrollment.save!
          enrolled += 1
        end
      end
    end

    msg += "Imported #{count} students from #{params[:file].original_filename}. "
    if (params[:section] != '')
      msg += "Enrolled #{enrolled} students in #{Section.find(params[:section]).name}. "
    end
    msg += "Skipped #{dupes} students who were already in the database."

    redirect_to students_path, notice: msg
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student,
          notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student,
          notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url,
        notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary Internet,
    # only allow the white list through.
    def student_params(p = params)
      p.require(:student).permit(
        :guid, :preferred_name, :given_name, :family_name,
        :dob, :cohort,
        :gpa, :gpa_updated)
    end
end
