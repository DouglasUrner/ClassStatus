class StatusController < ApplicationController
  helper StudentsHelper

  def index
    @enrollments = Enrollment.where(section_id: params[:id])
  end

  def show
  end
end
