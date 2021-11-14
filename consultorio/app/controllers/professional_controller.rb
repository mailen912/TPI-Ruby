class ProfessionalController < ApplicationController

    def index 
        #@users=User.all
    end

    def edit(id,new_name) #rename
        prof=Professional.find(id)
        prof.name=new_name
        if prof.valid?
            prof.update(name:new_name)
            puts "sii"#pudo renombrar
        else
            puts "noo"#no pudp
        end

    end
    def create(name)
        a_professional=Professional.new
        a_professional.name=name
        if a_professional.valid?
            a_professional.save
        else
            puts "noo es valido"
        end
    end

    def delete(id)
        #if not Appointment.where(professional_id: id).first #el professional no tiene turnos guardados
    end


end
