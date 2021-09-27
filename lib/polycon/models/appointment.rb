module Polycon
    module Models
        class Appointment
            attr_accessor :date, :name, :surname, :phone, :notes
            def initialize(date,name,surname,phone,notes="")
                self.date=date
                self.name=name
                self.surname=surname
                self.phone=phone
                self.notes=notes
            end
        end
    end
end