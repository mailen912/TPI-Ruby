require 'fileutils'
require 'date'
module Polycon
    module Models
        class Appointment
            attr_accessor :date, :professional, :name, :surname, :phone, :notes
            def initialize(date, professional, name=nil, surname=nil, phone=nil, notes="")
                self.date=date
                self.name=name
                self.professional=professional
                self.surname=surname
                self.phone=phone
                self.notes=notes
            end
            

            def valid_date?
                begin
                    DateTime.strptime(self.date , "%Y-%m-%d %H:%M ")
                    return true
                rescue => exception
                    return false #No es valida la fecha
                end
                
            end

            def valid_day?
                begin
                    DateTime.strptime(self.date , "%Y-%m-%d")
                    return true
                rescue => exception
                    return false #No es valida la fecha
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
            def valid_time?(schedule)
                
                schedule.include?(self.date.split(" ")[1])
                
            end 

            def is_sunday?
                Date.parse(self.date.split(" ")[0]).strftime("%u") == "7"
            end


            

            def self.create(date,professional, name, surname, phone, notes="")
                
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                an_appointment=Appointment.new(date,professional)
                if not an_appointment.valid_date?
                    raise "Por favor, ingrese una fecha con formato valido. Por ejemplo:'2021-09-30 13:00'"
                end
                if not an_appointment.valid_time?(schedule)
                    raise "No se pudo crear el turno. Los horarios permitidos para sacar turno son entre las 10:00 y las 20:30 y solo en los minutos: 00 y 30. Por ejemplo: 11:30"
                end
                if  an_appointment.is_sunday?
                    raise "No se dan turnos para los dias domingo"
                end
                if Store.appointment_exists?(professional,date)
                     raise "La fecha ingresada no esta disponible, por favor solicite otra"
                end
                an_appointment.name=name
                an_appointment.surname=surname
                an_appointment.phone=phone
                an_appointment.notes=notes
                Store.save_appointment(an_appointment)
                return an_appointment
            end


            def self.reschedule(old_date, new_date, professional)
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                an_old_appointment=Appointment.new(old_date,professional)
                a_new_appointment=Appointment.new(new_date,professional)
                if not an_old_appointment.valid_date? or not a_new_appointment.valid_date?
                    raise "Por favor, ingrese fechas validas. Por ejemplo:'2021-09-30 13:00'"
                end
                if not a_new_appointment.valid_time?(schedule)
                    raise "No se pudo reagendar el turno. Los horarios permitidos para sacar turno son entre las 10:00 y las 20:30 y solo en los minutos: 00 y 30. Por ejemplo: 11:30"
                end
                if  a_new_appointment.is_sunday?
                    raise "No se dan turnos para los dias domingo"
                end
                if not Store.appointment_exists?(professional, old_date)
                    raise "No existe el turno con fecha y hora #{old_date} para el profesional #{professional}"
                else
                    Store.rename_appointment(old_date,new_date,professional)
                    return a_new_appointment
                end
            end
            

            def self.cancel_all(professional)
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                Store.cancel_all_appointments(professional)
                
            end

            def cancel()
                if not Store.professional_exists?(self.professional)
                    raise "El profesional que ingresa no existe"
                end
                
                if not self.valid_date?
                    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
                end
                if not Store.appointment_exists?(self.professional,self.date)
                    raise "El turno que intenta cancelar no existe"
                end
                Store.cancel_appointment(self.professional,self.date)
                
            end
            
            def show()
                if not Store.professional_exists?(self.professional)
                    raise "El profesional que ingresa no existe"
                end
                if not self.valid_date?
                    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
                end
                if not Store.appointment_exists?(self.professional,self.date)
                    raise "El turno que intenta visualizar no existe"
                end
                Store.read_appointment(self)
                

            end

            def edit(options)
                if not Store.professional_exists?(self.professional)
                    raise "El profesional que ingresa no existe"
                end
               
                if not self.valid_date?
                    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
                end
                if not Store.appointment_exists?(self.professional,self.date)
                    raise "El turno que intenta editar no existe"
                end
                Store.read_appointment(self)
                if options.has_key?(:surname)
                    self.surname=options[:surname]
                end
                if options.has_key?(:name)
                    self.name=options[:name]
                end
                if options.has_key?(:phone)
                    self.phone=options[:phone]
                end
                if options.has_key?(:notes)
                    self.notes=options[:notes]
                end
                
                Store.save_appointment(self)
                self

            end

            def self.list(professional, date=nil)
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                turnos=[]
                if date #es una fecha
                    an_appointment=Appointment.new(date,professional)
                    if not an_appointment.valid_day?
                        raise "El dia ingresado no es valido. Ejemplo de formato valido:'2021-10-11' "
                    end
                    turnos=Store.get_appointments_by_day_and_professional(date, professional)
                    

                else
                    turnos=Store.get_appointments_by_professional(professional)
                    
                end
                return turnos
            end

            def self.to_export_by_day(day, professional=nil)
                an_appointment=Appointment.new(day,professional)
                if not an_appointment.valid_day?
                    raise "El dia ingresado no es valido. Ejemplo de formato valido:'2021-10-11' "
                end
                if professional 
                    if not Store.professional_exists?(professional)
                        raise "El profesional que ingresa no existe"
                    end
                    turnos=Store.get_appointments_by_day_and_professional(day, professional)

                else
                    turnos=Store.get_appointments_by_day(day)
                    
                end
                return turnos
            end

            def self.get_week(day)
                num_resta = Integer(Date.parse(day).strftime("%u"))-1 
                monday = Date.parse(day) - num_resta
                #puts monday
                week=[]
                week.push(monday.to_s)
                for d in (1..5)
                    week.push((monday + d).to_s)
                    puts (monday + d).to_s
                end
                week
            end
            def self.to_export_by_week(day, professional=nil)
                an_appointment=Appointment.new(day,professional)
                if not an_appointment.valid_day?
                    raise "El dia ingresado no es valido. Ejemplo de formato valido:'2021-10-11' "
                end
                if professional 
                    if not Store.professional_exists?(professional)
                        raise "El profesional que ingresa no existe"
                    end
                    week = get_week(day)
                    turnos=Store.get_appointments_by_week_and_professional(week, professional)

                else
                    week = get_week(day)
                    turnos=Store.get_appointments_by_week(week)
                    
                end
                return turnos
            end

             

        end
    end
end
