class StatusController < ApplicationController
  def index
    @students = Student.all
  end
end
