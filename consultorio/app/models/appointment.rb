require 'date'
class Appointment < ApplicationRecord
  belongs_to :professional
  validates :date, presence: true,uniqueness: { scope: [:professional_id] }
  validates :name, presence: true
  validates :surname, presence:true
  validates :phone, presence:true
  validates :notes, presence:false, length: { maximum: 50 }

  validate  :is_sunday?, :valid_time?,   :valid_date?


  def is_sunday?
    if self.date.sunday?
      errors.add :date, "Professionals don't work on Sundays, please request another day"
  
    end
  end

  def self.schedule
    @schedule ||= begin
        schedule=[]
        (10..20).each do |hs|
            schedule.push("#{hs}:00")
            schedule.push("#{hs}:30")
        end
        schedule
      end
  end
  def valid_time?
    
    if not Appointment.schedule.include?(self.date.strftime('%H:%M')) 
      errors.add :date, "The appointment could not be created. The hours allowed to take appointments are between 10:00 and 20:30 and only in the minutes: 00 and 30. For example: 11:30"
    end
  end 

  def valid_date?
    begin
      DateTime.strptime(self.date.to_s,  '%Y-%m-%d %H:%M:%S')
    rescue => exception
      errors.add :date, "The date format is invalid"
    end
    
  end

end

