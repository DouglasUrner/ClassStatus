class BlocksController < ApplicationController
  before_action :set_block, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /blocks
  def index
    @blocks = Block.order(sort_column + " " + sort_direction)
  end

  # GET /blocks/1
  def show
  end

  # GET /blocks/new
  def new
    @block = Block.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks
  def create
    @block = Block.new(block_params)

    if @block.save
      redirect_to blocks_path,
        notice: 'Block was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /blocks/1
  def update
    if @block.update(block_params)
      redirect_to blocks_path,
        notice: "Block #{@block.name} was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /blocks/1
  def destroy
    @block.destroy
    redirect_to blocks_url,
      notice: "Block #{@block.name} was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def block_params
      params.require(:block).permit(:name, :sort_order)
    end

    # Helpers for sortable table columns.
    def sort_column
      Block.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
