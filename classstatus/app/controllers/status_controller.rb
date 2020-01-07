class StatusController < ApplicationController
  helper StudentsHelper

  def show
    if (params[:id] == nil)
      params[:id] = session[:active_block] || 1
    end
    @enrollments = Enrollment.where(section_id: params[:id])
    session[:active_block] = params[:id].to_i
  end

end
