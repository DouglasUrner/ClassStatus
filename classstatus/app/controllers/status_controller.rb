class StatusController < ApplicationController
  helper StudentsHelper

  @active_section = 1

  def show
    if (params[:id] == nil)
      params[:id] = @active_section
    end
    @enrollments = Enrollment.where(section_id: params[:id])
    @active_section = params[:id].to_i
  end

end
