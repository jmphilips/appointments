class Appointment
  include ActiveModel::Model
  include SecureRandom

  attr_accessor :start_time, :end_time, :schedule_id, :id

  def self.all
    ObjectSpace.each_object(self)
  end

  def self.count
    self.all.count
  end

  def self.find(id)
    self.all.find { |schedule| schedule.id == uuid }
  end

  def initialize(args)
    @start_time = args[:start_time]
    @end_time = args[:end_time]
    @schedule_id = args[:schedule_id]
    @id = SecureRandom.uuid
  end
end