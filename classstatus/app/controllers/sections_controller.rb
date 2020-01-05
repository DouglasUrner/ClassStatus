class SectionsController < ApplicationController
    def index
      @sections = Section.order(:name)
    end

    def show
      @section = Section.find(params[:id])
      @enrollments = Enrollment.where(section_id: @section)
    end

    def new
      @section = Section.new
    end

    def edit
      @section = Section.find(params[:id])
    end

    def create
      # render plain: params[:section].inspect
      @section = Section.new(section_params)

      if @section.save
        redirect_to @section
      else
        render 'new'
      end
    end

    def update
      @section = Section.find(params[:id])

      if @section.update(section_params)
        redirect_to sections_path
      else
        render 'edit'
      end
    end

    def destroy
      @section = Section.find(params[:id])
      @section.destroy

      redirect_to sections_path
    end

    private
      def section_params
        params.require(:section).permit(:name, :course_id)
      end
end
