class SectionsController < ApplicationController
  before_action :set_section,
    only: [:show, :edit, :update, :destroy,
      :seating, :attendance, :progress]
  before_action :set_enrollments,
    only: [:show, :seating, :attendance, :progress]
  before_action :check_for_students,
    only: [:seating, :attendance, :progress]

  helper SeatmapHelper

  # GET /sections
  # GET /sections.json
  def index
    # XXX: This is fragile, should be sorting on the block sort order.
    #      Or better, there should be a section sort method.
    @sections = Section.order(:block_id)
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section,
          notice: 'Section was successfully created.' }
        format.json { render :show,
          status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section,
          notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url,
        notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # /sections/1/seating
  def seating
  end

  # POST /sections/1/attendance
  def attendance
    # Start here, then:
    # - normalize the attendance records
    # - redirect to attendance_records#create
  end

  def progress
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      if (params[:id] == nil)
        params[:id] = session[:active_block]
        if (session[:active_block])
          # TODO: try to infer the section based on the current time.
          params[:id] = 1
        end
      end
      session[:active_block] = params[:id].to_i
      @section = Section.find(params[:id])
    end

    # Must be called after set_section
    # TODO: handle error when params[:id] is not set, call set_section?
    # TODO: maybe return a hash of active and dropped students?
    def set_enrollments
      @enrollments = Enrollment.where(section_id: params[:id])
        .includes(:student).order('students.family_name')
      @active = @enrollments.where(dropped_course: nil)
      @dropped = @enrollments.where.not(dropped_course: nil)
    end

    # Check that we have some students.
    def check_for_students
      # TODO: set a message.
      # TODO: handle on a per section basis?
      if (!Student.exists?)
        # First we need students, so when the students table is empty
        # go to the import page.
        redirect_to students_path
      end
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def section_params
      params.require(:section).permit(:course_id, :year_id, :term_id, :block_id)
    end
end
