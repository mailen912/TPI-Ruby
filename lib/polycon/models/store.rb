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
                    #puts(an_appointment.surname)
                    an_appointment.name=f.gets.chomp
                    an_appointment.phone=f.gets.chomp
                    an_appointment.notes=f.gets.chomp
                end
                return an_appointment
            end

            def self.get_appointments_by_day(day)
                #este devuelve objetos appointments con el dia day 
                turnos=[]
                Dir.entries(root_path()).reject{|entry| entry == "." || entry == ".."}.each do |prof|
                    Dir.entries(professional_path(prof)).reject{|entry| entry == "." || entry == ".."}.each do |date|
                        if date.split("_")[0] == day
                            an_appointment=Appointment.new(date.gsub("_"," ").reverse.sub("-".reverse,":".reverse).reverse.gsub(".paf",""),prof)
                            turnos.push(read_appointment(an_appointment))
                        end
                    end
                end
                turnos
            end
            def self.get_appointments_by_day_and_professional(day, professional)
                #este devuelve objetos appointments con el dia day y el profesional professional
                turnos=[]
                    Dir.entries(professional_path(professional)).reject{|entry| entry == "." || entry == ".."}.each do |date|
                        if date.split("_")[0] == day
                            an_appointment=Appointment.new(date.gsub("_"," ").reverse.sub("-".reverse,":".reverse).reverse.gsub(".paf",""),professional)
                            turnos.push(read_appointment(an_appointment))
                        end
                    end
                turnos
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


            def self.get_appointments_by_week(week)
                #este devuelve objetos appointments con el dias de la semanda en que se encuentra day 
                turnos=[]
                Dir.entries(root_path()).reject{|entry| entry == "." || entry == ".."}.each do |prof|
                    Dir.entries(professional_path(prof)).reject{|entry| entry == "." || entry == ".."}.each do |date|
                        if week.include?date.split("_")[0] 
                            an_appointment=Appointment.new(date.gsub("_"," ").reverse.sub("-".reverse,":".reverse).reverse.gsub(".paf",""),prof)
                            turnos.push(read_appointment(an_appointment))
                        end
                    end
                end
                turnos
            end
            def self.get_appointments_by_week_and_professional(week, professional)
            #este devuelve objetos appointments con el dias de la semanda en que se encuentra day 
                turnos=[]
                           
                Dir.entries(professional_path(professional)).reject{|entry| entry == "." || entry == ".."}.each do |date|
                    if week.include?date.split("_")[0] 
                        an_appointment=Appointment.new(date.gsub("_"," ").reverse.sub("-".reverse,":".reverse).reverse.gsub(".paf",""),professional)
                        turnos.push(read_appointment(an_appointment))
                    end
                end
                
                turnos
            end

            def self.get_appointments_by_professional(professional)
                turnos=[]
                    Dir.entries(professional_path(professional)).reject{|entry| entry == "." || entry == ".."}.each do |date|
                        an_appointment=Appointment.new(date.gsub("_"," ").reverse.sub("-".reverse,":".reverse).reverse.gsub(".paf",""),professional)
                        turnos.push(read_appointment(an_appointment))
                        
                    end
                turnos
            end

            

        end
    end
end
