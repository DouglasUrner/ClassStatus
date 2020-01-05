class StatusController < ApplicationController
  helper StudentsHelper
  
  def index
    @students = Student.all
  end
end
