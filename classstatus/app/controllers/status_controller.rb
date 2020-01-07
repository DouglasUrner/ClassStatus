class StatusController < ApplicationController
  helper StudentsHelper

  def show
    if (!Student.exists?)
      # First we need students, so when the students table is empty
      # go to the import page.
      redirect_to students_path
    end
    if (params[:id] == nil)
      # If the block is not specified, make a guess.
      # For now, the last block viewed or block 1.
      # TODO: infer from schedule.
      params[:id] = session[:active_block] || 1
    end
    @enrollments = Enrollment.where(section_id: params[:id])
    session[:active_block] = params[:id].to_i
  end

end
