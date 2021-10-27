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
            
            def exists?
                name_file=self.date.gsub(" ","_").gsub(":","-")
                if File.exist?"#{Dir.home}/.polycon/#{self.professional}/#{name_file}.paf"
                   return  true
                else 
                   return false
                end
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



            

            def self.create(date,professional, name, surname, phone, notes="")
                
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                an_appointment=Appointment.new(date,professional)
                if not an_appointment.valid_date?
                    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
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

            def self.cancel(date,professional)
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                an_appointment=Appointment.new(date,professional)
                if not an_appointment.valid_date?
                    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
                end
                if not Store.appointment_exists?(professional,date)
                    raise "El turno que intenta cancelar no existe"
                end
                Store.cancel_appointment(professional,date)
                
            end
            
            def self.show(date, professional)
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                an_appointment=Appointment.new(date,professional)
                if not an_appointment.valid_date?
                    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
                end
                if not Store.appointment_exists?(professional,date)
                    raise "El turno que intenta visualizar no existe"
                end
                Store.read_appointment(an_appointment)
                

            end

            def self.edit(date,professional,options)
                if not Store.professional_exists?(professional)
                    raise "El profesional que ingresa no existe"
                end
                an_appointment=Appointment.new(date,professional)
                if not an_appointment.valid_date?
                    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
                end
                if not Store.appointment_exists?(professional,date)
                    raise "El turno que intenta editar no existe"
                end
                an_appointment=Store.read_appointment(an_appointment)
                if options.has_key?(:surname)
                    an_appointment.surname=options[:surname]
                end
                if options.has_key?(:name)
                    an_appointment.name=options[:name]
                end
                if options.has_key?(:phone)
                    an_appointment.phone=options[:phone]
                end
                if options.has_key?(:notes)
                    an_appointment.notes=options[:notes]
                end
                
                Store.save_appointment(an_appointment)

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
                    turnos=Store.get_appointments_by_professional_and_day(professional,date)

                else
                    turnos=Store.get_appointments_by_professional(professional)
                    
                end
                return turnos
            end

            def self.to_export(day, professional=nil)
                an_appointment=Appointment.new(day,professional)
                if not an_appointment.valid_day?
                    raise "El dia ingresado no es valido. Ejemplo de formato valido:'2021-10-11' "
                end
                if professional 
                    if not Store.professional_exists?(professional)
                        raise "El profesional que ingresa no existe"
                    end
                    turnos=Store.get_appointments_by_professional_and_day(professional,dat)

                else
                    turnos=Store.get_appointments_by_day(day)
                    
                end
                return turnos
            end

             

        end
    end
end
