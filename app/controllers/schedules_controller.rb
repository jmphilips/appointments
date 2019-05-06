class SchedulesController < ApplicationController

  def create
    schedule = Schedule.new()
    render json: schedule
  end
end