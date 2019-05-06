class SchedulesController < ApplicationController
  def create
    @schedule = Schedule.new()
    render json: @schedule
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.add_appointment(params[:start_time], params[:end_time]) if params[:start_time] && params[:end_time]
    @schedule.remove_appointment(params[:appointment_id]) if params[:appointment_id]
    render json: @schedule
  end

  def show
    @schedule = Schedule.find(params[:id])
    render json: @schedule
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    render json: @schedule
  end
end