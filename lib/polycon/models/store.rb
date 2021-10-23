require 'fileutils'
require 'date'
module Polycon
    module Models
        class Store
            
            def self.root_path
                @root_path ||= begin
                    root_path = "#{Dir.home}/.polycon"
                    FileUtils.mkdir_p(root_path)
                    root_path
                end                   
            end


            def self.professional_path(professional)
                "#{root_path}/#{professional}"
            end

            def self.professional_exists?(professional)
                Dir.exist?(professional_path(professional))
                
            end

            def self.rename_professional(old_name, new_name)
                File.rename(professional_path(old_name),professional_path(new_name))
            end

            def self.create_professional(name)
                FileUtils.mkdir_p(professional_path(name))
            end

            def self.has_appointments?(name)
                Dir.empty?(professional_path(name))
            end

            def self.any_professional_exist?
                File. exist?(root_path)
            end

            def self.professionals
                Dir.entries(root_path).reject{|entry| entry == "." || entry == ".."}
            end
            
            def self.appointment_path(professional, date)
                name_file=date.gsub(" ","_").gsub(":","-")
                "#{professional_path(professional)}/#{name_file}.paf"
            end

            def self.appointment_exists?(professional, date)
                File.exist?(appointment_path(professional,date))
            end

            def self.save_appointment(an_appointment)
                path=appointment_path(an_appointment.professional,an_appointment.date)
                File.open( path, "w+") do |f|
                    f.write( "#{an_appointment.surname} \n")
                    f.write( "#{an_appointment.name} \n")
                    f.write( "#{an_appointment.phone} \n")
                    f.write( "#{an_appointment.notes} \n")
                end
                return an_appointment
            end

            def self.rename_appointment(old_date, new_date, professional)
                File.rename(appointment_path(professional,old_date),appointment_path(professional,new_date))
            end

            def self.cancel_all_appointments(professional) 
                FileUtils.rm_rf(professional_path(professional)) #elimina el directorio con todo su contenido(todos los turnos)
                Professional.create(professional) #crea el profesional sin turnos
            end

            def self.cancel_appointment(professional,date) 
                FileUtils.rm(appointment_path(professional,date))
            end
            
            def self.read_appointment(an_appointment)

                File.open(appointment_path(an_appointment.professional,an_appointment.date),'r') do |f|
                    an_appointment.surname=f.gets.chomp
                    an_appointment.name=f.gets.chomp
                    an_appointment.phone=f.gets.chomp
                    an_appointment.notes=f.gets.chomp
                end
                return an_appointment
            end

    

            def self.get_appointments_by_professional(professional)
                turnos=[]
                Dir.entries(professional_path(professional)).reject{|entry| entry == "." || entry == ".."}.each do |fecha|
                    turnos.push(fecha.gsub("_"," ").reverse.sub("-".reverse,":".reverse).reverse.gsub(".paf",""))
                end
                turnos
            end

            def self.get_appointments_by_professional_and_day(professional,day)
                turnos=[]
                    Dir.entries(professional_path(professional)).reject{|entry| entry == "." || entry == ".."}.each do |fecha|
                
                        if fecha.split("_")[0] == day
                            turnos.push(fecha.gsub("_"," ").reverse.sub("-".reverse,":".reverse).reverse.gsub(".paf",""))
                        end
                    end
                turnos
            
            end

        end
    end
end
