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
      @student = Student.new(student_params(p))
      @student.save!
      count += 1
    end

    redirect_to students_path,
      notice: "#{count} students imported from #{params[:file].original_filename}"
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
      p.require(:student).permit(:given_name, :family_name, :preferred_name, :pronouns, :github_user)
    end
  end
