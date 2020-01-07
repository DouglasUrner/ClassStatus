require 'json'

class StudentsController < ApplicationController
  helper StudentsHelper

  def index
    @students = Student.order(:family_name).order(:preferred_name).order(:given_name)
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  # Impart a JSON formatted class roster.
  def import
    count = 0; enrolled = 0; dupes = 0

    roster = JSON.parse( File.read(params[:file].path) )

    roster['students'].map do |s|

      p = ActionController::Parameters.new(student: s)

      # Check to see if we've already imported this student before proceeding.
      if (Student.exists?(guid: s['guid']))
        @student = Student.find_by(guid: s['guid'])
        dupes += 1
      else
        @student = Student.new(student_params(p))
        @student.save!
        count += 1
      end

      # Enroll nwe students in section
      if (!Enrollment.exists?(student_id: @student, section_id: params[:section]))
        @enrollment = Enrollment.new()
        @enrollment.student_id = @student.id
        @enrollment.section_id = params[:section]
        # TODO: add active flag to Enrollment
        @enrollment.save!
        enrolled += 1
      end
    end

    redirect_to students_path,
      notice: "Imported #{count} students from #{params[:file].original_filename}. " +
              "Enrolled #{enrolled} students in #{Section.find(params[:section]).course.name}. " +
              "Skipped #{dupes} students who were already in the database."
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    # render plain: params[:student].inspect
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student
    else
      render 'new'
    end
  end

  def update
    @student = Student.find(params[:id])

    if @student.update(student_params)
      redirect_to @student
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    redirect_to students_path
  end

  private
    def student_params(p = params)
      p.require(:student).permit(
          :guid, :given_name, :family_name, :preferred_name,
          :gender, :pronouns, :known_to,
          :dob, :cohort,
          :email, :github_user, :gpa)
    end
  end
