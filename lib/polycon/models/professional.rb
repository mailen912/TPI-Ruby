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

            def rename(new_name)
                if not Store.professional_exists?(self.name)
                    raise "El profesional no existe"
                else
                    Store.rename_professional(self.name,new_name)
                    self.name=new_name
                end
            end
        
            def self.list_professionals
                if Store.any_professional_exist?
                    todos=[]
                    for p in Store.professionals
                        todos.push(Professional.new(p))
                    end
                    todos
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
            
            def delete 
                if not Store.professional_exists?(self.name)
                    raise "El profesional que intenta eliminar no existe"
                elsif not Store.has_appointments?(self.name)
                    raise "El profesional que intenta eliminar tiene turnos"
                else
                    Dir.delete("#{Dir.home}/.polycon/#{self.name}")
                    
                end
            end

        end
    end
end
