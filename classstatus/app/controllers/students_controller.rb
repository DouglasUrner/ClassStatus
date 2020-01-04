require 'json'

class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  # Impart a JSON formatted class roster.
  def import
    count = 0
    dupes = 0

    roster = File.read(params[:file].path)
    roster_hash = JSON.parse(roster)

    students = roster_hash['students']
    students.map do |s|
      p = ActionController::Parameters.new(student: s.to_hash)
      # Check to see if we've alread imported
      # this student before importing.
      if (Student.exists?(guid: p[:guid]))
        dupes += 1
      else
        @student = Student.new(student_params(p))
        @student.save!
        count += 1
      end
    end

    redirect_to students_path,
      notice: "Imported #{count} students from #{params[:file].original_filename}, #{dupes} duplicates skipped"
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
