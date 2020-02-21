class AttendanceRecordsController < ApplicationController
  before_action :set_attendance_record, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /attendance_records
  def index
    @attendance_records = AttendanceRecord.order(sort_column + " " + sort_direction)
  end

  # GET /attendance_records/1
  def show
  end

  # GET /attendance_records/new
  def new
    @attendance_record = AttendanceRecord.new
  end

  # GET /attendance_records/1/edit
  def edit
  end

  # POST /attendance_records
  def create
    @attendance_record = AttendanceRecord.new(attendance_record_params)

    if @attendance_record.save
      redirect_to @attendance_record,
        notice: 'Attendance record was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /attendance_records/1
  def update
    if @attendance_record.update(attendance_record_params)
      redirect_to @attendance_record,
        notice: 'Attendance record was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /attendance_records/1
  def destroy
    @attendance_record.destroy
    redirect_to attendance_records_url,
      notice: 'Attendance record was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_record
      @attendance_record = AttendanceRecord.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attendance_record_params
      params.require(:attendance_record).permit(
        :section_id, :student_id, :attendance_date,
        :primary, :secondary, :annotations)
    end

    # Helpers for sortable table columns.
    def sort_column
      AttendanceRecord.column_names.include?(params[:sort]) ? params[:sort] : 'attendance_date'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
