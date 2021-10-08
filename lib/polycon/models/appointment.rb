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
                    print("acaaaa")
                    print(self.date)
                    print(DateTime.parse(self.date))
                    return true
                rescue => exception
                    return false #No es valida la fecha
                end
                
            end

            def self.create(date,professional, name, surname, phone, notes="")
                a_professional=Polycon::Models::Professional.new(professional)
                
                directorio="#{Dir.home}/.polycon/#{professional}"

                if not a_professional.exists?
                    raise "El profesional que ingresa no existe"
                end
                #name_file=date.gsub(" ","_").gsub(":","-")
                an_appointment=Appointment.new(date,professional)
                #if not an_appointment.valid_date?
                #    raise "Por favor, ingrese una fecha valida. Por ejemplo:'2021-09-30 13:00'"
                #end
                if an_appointment.exists?
                     raise "La fecha ingresada no esta disponible, por favor solicite otra"
                end
                name_file=date.gsub(" ","_").gsub(":","-")
                FileUtils.cd(directorio) do
                    File.new "#{name_file}.paf", "w"
                    File.open( "#{name_file}.paf", "w+") do |f|
                        f.write( "#{surname} \n")
                        f.write( "#{name} \n")
                        f.write( "#{phone} \n")
                        f.write( "#{notes} \n")
                    end
                end
                return an_appointment
            end
            def self.reschedule(old_date, new_date, professional)
                a_professional=Professional.new(professional)
                if not a_professional.exists?
                    raise "El profesional que ingresa no existe"
                else
                    old_name_file=old_date.gsub(" ","_").gsub(":","-")
                    old_appointment=Appointment.new(old_name_file,professional)
                    new_name_file=new_date.gsub(" ","_").gsub(":","-")
                    if not old_appointment.exists?
                        raise "No existe el turno con fecha y hora #{old_date} para el profesional #{professional}"
                    else
                        File.rename("#{Dir.home}/.polycon/#{professional}/#{old_name_file}.paf","#{Dir.home}/.polycon/#{professional}/#{new_name_file}.paf")
                    end
                end
            end

            def self.cancel_all(professional)
                a_professional=Professional.new(professional)
                if not a_professional.exists?
                    
                    raise "El profesional que ingresa no existe"
                end
                directorio="#{Dir.home}/.polycon/#{professional}" 
                FileUtils.rm_rf(directorio)
                Professional.create(professional)
            end

            def self.cancel(date,professional)
                a_professional=Professional.new(professional)
                if not a_professional.exists?
                    raise "El profesional que ingresa no existe"
                end
                an_appointment=Appointment.new(date,professional)
                if not an_appointment.exists?
                    raise "El turno que intenta cancelar no existe"
                end
                name_file=date.gsub(" ","_").gsub(":","-")
                turno="#{Dir.home}/.polycon/#{professional}/#{name_file}.paf" 
                FileUtils.rm(turno)
                
            end

            

            

        end
    end
end