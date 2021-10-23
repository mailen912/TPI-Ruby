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
                if not Store.professional_exists?(old_name)
                    raise "El profesional no existe"
                else
                    Store.rename_professional(old_name,new_name)
                    a_professional=Professional.new(new_name)
                end
            end
        
            def self.list_professionals
                if Store.any_professional_exist?
                    Store.professionals
                else 
                    raise "No hay profesionales guardados"
                end

            end
        
            def self.look_professional(name)
                @@professionals.detect { |person| person.name==name   }
            end
        
            def self.create(name)
               #@@professionals << a_professional #esta mal??
                if not Store.professional_exists?(name)
                     Store.create_professional(name)
                    a_professional=Professional.new(name)

                else 
                    raise "El profesional que intenta crear ya existe"
                end   
            end
            
            def self.delete (name)
                if not Store.professional_exists?(name)
                    raise "El profesional que intenta eliminar no existe"
                elsif not Store.has_appointments?(name)
                    raise "El profesional que intenta eliminar tiene turnos"
                else
                    Dir.delete("#{Dir.home}/.polycon/#{name}")
                    
                end
            end

        end
    end
end
