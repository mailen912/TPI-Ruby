require 'fileutils'
module Polycon
    module Models
        class Professional
            attr_accessor :name
            #@@professionals=[]
            def initialize(name)
                @name=name
                @appointments=[]
            end
            def self.rename(old_name,new_name)
                if Dir.exist?("#{Dir.home}/.polycon/#{old_name}")
                    File.rename("#{Dir.home}/.polycon/#{old_name}","#{Dir.home}/.polycon/#{new_name}")
                    a_professional=Professional.new(new_name)
                else
                    raise
                end
            end
        
            def self.list_professionals
                if File. exist?("#{Dir.home}/.polycon")
                    todos = Dir.entries("#{Dir.home}/.polycon")
                else
                    raise
                end

            end
        
            def self.look_professional(name)
                @@professionals.detect { |person| person.name==name   }
            end
        
            def self.create(name)
               #@@professionals << a_professional #esta mal??
               if Dir.exist?("#{Dir.home}/.polycon")
                 todos = Dir.entries("#{Dir.home}/.polycon")
                 existe = todos.any? {|prof| prof == name}
               else
                existe=false
               end
                if not existe
                    FileUtils.mkdir_p "#{Dir.home}/.polycon/#{name}"
                    a_professional=Professional.new(name)
                    return a_professional
                else 
                    raise
                end   
            end
            #def add_appointment(an_appointment)
             #  self.appointments << an_appointment
           # end
            #def tiene_turnos?
             #  (self.appointments).empty?
            #end
            def self.delete (name)
                if not Dir.exist?("#{Dir.home}/.polycon/#{name}")
                    raise "El profesional que intenta eliminar no existe"
                elsif not Dir.empty?("#{Dir.home}/.polycon/#{name}")
                    raise "El profesional que intenta eliminar tiene turnos"
                else
                    Dir.delete("#{Dir.home}/.polycon/#{name}")
                    
                end
            end

        end
    end
end