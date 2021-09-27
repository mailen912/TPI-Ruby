module Polycon
    module Models
        class App
            attr_accessor :profesionals
            def initialize()
              self.profesionals=[]    
            end
            def add_professional(name)
                #me falta comprobar que no haya otro profesional con ese nombre
               new_professional=Professional.new(name)
               self.professionals << new_professional
               puts "creadoo"
            end
            def list
                self.profesionals.each do |professional|
                    puts professional.name 
                end
            end
            def delete (professional_to_delete)
                if !professional_to_delete.tiene_turnos? 
                    self.profesionals.delete(professional_to_delete)
                    return "Se pudo eliminar correctamente"
                end
            else 
                return "El profesional que intenta eliminar tiene turnos, intentelo mas adelante"
        end
    end
end