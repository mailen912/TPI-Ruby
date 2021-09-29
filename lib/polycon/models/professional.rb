module Polycon
    module Models
        class Professional
            attr_accessor :name
            @@professionals=[]
            def initialize(name)
                @name=name
                @appointments=[]
            end
            def rename(new_name)
                @name=new_name
            end
        
            def self.list_professionals
                @@professionals.each do |person|
                    puts person.name
                end
            end
        
            def self.look_professional(name)
                @@professionals.detect { |person| person.name==name   }
            end
        
            def self.add_professional(name)
                a_professional=Professional.new(name)
                @@professionals << a_professional
                puts "Se agrego un profesional exitosamente"
            end
            #def add_appointment(an_appointment)
             #  self.appointments << an_appointment
           # end
            #def tiene_turnos?
             #  (self.appointments).empty?
            #end

        end
    end
end