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
            
            def exists?
                # retorna un true si el profesional existe, y false si no
                if  Dir.exist?("#{Dir.home}/.polycon/#{self.name}")
                    return true
                else 
                    return false
                end
            end

            def self.rename(old_name,new_name)
                a_professional=Professional.new(old_name)
                if not a_professional.exists?
                    raise "El profesional no existe"
                else
                    File.rename("#{Dir.home}/.polycon/#{old_name}","#{Dir.home}/.polycon/#{new_name}")
                    a_professional=Professional.new(new_name)
                end
            end
        
            def self.list_professionals
                if File. exist?("#{Dir.home}/.polycon")
                    todos = Dir.entries("#{Dir.home}/.polycon")
                else 
                    raise "No hay profesionales guardados"
                end

            end
        
            def self.look_professional(name)
                @@professionals.detect { |person| person.name==name   }
            end
        
            def self.create(name)
               #@@professionals << a_professional #esta mal??
                a_professional=Professional.new(name)
                if not a_professional.exists?
                    FileUtils.mkdir_p "#{Dir.home}/.polycon/#{name}"
                    return a_professional
                else 
                    raise "El profesional que intenta crear ya existe"
                end   
            end
            
            def self.delete (name)
                a_professional= Professional.new(name)
                if not a_professional.exists?
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