class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /sections
  def index
    @sections = Section.order(sort_column + " " + sort_direction)
  end

  # GET /sections/1
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
  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to sections_path,
        notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      redirect_to sections_path,
        notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sections/1
  def destroy
    @section.destroy
    redirect_to sections_url,
      notice: 'Section was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(:course_id, :academic_year_id, :term_id, :block_id)
    end

    # Helpers for sortable table columns.
    def sort_column
      Section.column_names.include?(params[:sort]) ? params[:sort] : 'block_id'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
