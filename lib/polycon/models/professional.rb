module Polycon
    module Models
        class Professional
            attr_accessor :name
            def initialize(name)
                self.name=name
                self.appointments=[]
            end
            def rename(new_name)
                self.name=new_name
            end
            def add_appointment(an_appointment)
               self.appointments << an_appointment
            end
            def tiene_turnos?
               (self.appointments).empty?
            end

        end
    end
end