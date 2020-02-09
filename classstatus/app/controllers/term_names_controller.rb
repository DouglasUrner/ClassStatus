class TermNamesController < ApplicationController
  before_action :set_term_name, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /term_names
  # GET /term_names.json
  def index
    @term_names = TermName.order(sort_column + " " + sort_direction)
  end

  # GET /term_names/1
  # GET /term_names/1.json
  def show
  end

  # GET /term_names/new
  def new
    @term_name = TermName.new
  end

  # GET /term_names/1/edit
  def edit
  end

  # POST /term_names
  # POST /term_names.json
  def create
    @term_name = TermName.new(term_name_params)

    respond_to do |format|
      if @term_name.save
        format.html { redirect_to term_names_path,
          notice: 'Term name was successfully created.' }
        format.json { render :show, status: :created, location: @term_name }
      else
        format.html { render :new }
        format.json { render json: @term_name.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /term_names/1
  # PATCH/PUT /term_names/1.json
  def update
    respond_to do |format|
      if @term_name.update(term_name_params)
        format.html { redirect_to term_names_path,
          notice: 'Term name was successfully updated.' }
        format.json { render :show, status: :ok, location: @term_name }
      else
        format.html { render :edit }
        format.json { render json: @term_name.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /term_names/1
  # DELETE /term_names/1.json
  def destroy
    @term_name.destroy
    respond_to do |format|
      format.html { redirect_to term_names_url, notice: 'Term name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term_name
      @term_name = TermName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_name_params
      params.require(:term_name).permit(:name, :short_name)
    end

    def sort_column
      TermName.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
