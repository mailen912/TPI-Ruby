require 'date'
class Appointment < ApplicationRecord
  belongs_to :professional
  validates :date, presence: true
  validates :name, presence: true
  validates :surname, presence:true
  validates :phone, presence:true
  validates :notes, presence:false, length: { maximum: 50 }
  validate :valid_day?, :is_sunday?, :valid_time?,  :valid_uniqueness?, :valid_date?

  def valid_day?
    begin
      puts "ACA"
      DateTime.strptime(self.date , "%Y-%m-%d")
      return true
    rescue => exception
      return false #No es valida la fecha
    end
  end
  def is_sunday?
    if self.date.sunday?
      errors.add :date, "No se dan turnos para los dias domingo"
  
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
      errors.add :date, "No se pudo crear el turno. Los horarios permitidos para sacar turno son entre las 10:00 y las 20:30 y solo en los minutos: 00 y 30. Por ejemplo: 11:30"
    end
  end 

  def valid_date?
    begin
      puts (self.date)
      self.date.strptime("%Y-%m-%d %H:%M")
    rescue => exception
      errors.add :date, "El formato de la fecha es invalido"
    end
    
  end

  def valid_uniqueness?
    if Appointment.where(date:self.date, professional_id:self.professional_id).first
      errors.add :date, "La fecha ingresada no esta disponible, por favor solicite otra"
    end
  end

end

