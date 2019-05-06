class Schedule
  include ActiveModel::Model

  attr_accessor :id, :appointments

  def initialize(args = {})
    @destroyed = false
    @id = SecureRandom.uuid
    @appointments = []
  end

  def appointments
    @appointments.sort_by { |x, y| x.start_time <=> y.start_time }
  end

  def add_appointment(start_time, end_time)
    if valid_appointment(start_time, end_time)
      appointment = Appointment.new({start_time: start_time, end_time: end_time, schedule_id: self.id})
      @appointments.push(appointment)
    end
  end

  def valid_appointment(start_time, end_time)
    return false if start_time > end_time
    @appointments.none? { |app| (app.start_time...app.end_time).to_a.include?(start_time || end_time) }
  end

  def remove_appointment(appointment_id)
    @appointments = @appointments.map { |appointment| appointment.id != appointment_id}
  end

  def delete
    self.delete
  end

  def self.all
    ObjectSpace.each_object(self)
  end

  def self.count
    self.all.count
  end

  def self.find(uuid)
    self.all.find { |schedule| schedule.id == uuid }
  end
end