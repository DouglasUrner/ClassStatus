class SectionsController < ApplicationController
  before_action :set_section,
    only: [:show, :edit, :update, :destroy,
      :seating, :attendance, :progress]
  before_action :set_enrollments,
    only: [:show, :seating, :attendance, :progress]

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
    #@enrollments = Enrollment.where(section_id: @section)
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

  def attendance
  end

  def progress
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      if (params[:id])
        @section = Section.find(params[:id])
      else
        # TODO: preserve the section when it is specified so that it can
        #       be defaulted. We might try to default the section based on
        #       the current time.
        @section = Section.find(1)
      end
    end

    def set_enrollments
      @enrollments = Enrollment.where(section_id: params[:id])
    end

    # Never trust parameters from the scary internet,
    # only allow the white list through.
    def section_params
      params.require(:section).permit(:course_id, :year_id, :term_id, :block_id)
    end
end
